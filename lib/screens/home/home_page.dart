import 'package:flutter/material.dart';

const studentId = '640710744';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentQuestionIndex = 0; // Keep track of the current question index

  final List<Map<String, dynamic>> quizData = [
    {
      'question': 'ถ้าพ่อกับแม่หย่ากันลูกเป็นของใคร?',
      'options': ['A.พ่อ', 'B.แม่', 'C.พี่ ป้า น้า อา', 'D.ไม่เป็นของใครเลย'],
      'correctIndex': 0,
      'selectedAnswer': -1,
    },
    {
      'question': 'ถ้าคุณเอาตังไปหยอดตู้น้ำอัดลม น้ำอัดลมเป็นของใคร?',
      'options': ['A.ตู้น้ำอัดลม', 'B.คุณ', 'C.ของบริษัทน้ำอัดลม', 'D.ไม่เป็นของใครเลย'],
      'correctIndex': 1,
      'selectedAnswer': -1,
    },
    {
      'question': 'คนตั้งคำถามไปเอามาจากไหน?',
      'options': ['A.Youtube', 'B.คิดเอา', 'C.ที่บ้านมีปัญหาเลยมาถาม', 'D.เพื่อน'],
      'correctIndex': 0,
      'selectedAnswer': -1,
    },
  ];

  final int questionCount = 3; // Total number of questions

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCenteredText('Good Morning', textTheme.headline6),
              SizedBox(height: 8.0),
              _buildCenteredText(studentId, textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black87,
              )),
              SizedBox(height: 8.0),
              _buildQuizView(),
              SizedBox(height: 8.0),
              _buildButtonPanel(),
              SizedBox(height: 8.0),
              _buildAnswer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenteredText(String text, TextStyle? style) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }

  Widget _buildQuestionAndOptions() {
    final currentQuestion = quizData[currentQuestionIndex];
    final question = currentQuestion['question'] as String;
    final options = currentQuestion['options'] as List<String>;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          _buildCenteredText(question, TextStyle(fontSize: 16.0)),
          SizedBox(height: 8.0),
          for (int i = 0; i < options.length; i++)
            _buildOption(i, options[i], currentQuestion),
        ],
      ),
    );
  }

  Widget _buildOption(int index, String option, Map<String, dynamic> currentQuestion) {
    final isSelected = index == currentQuestion['selectedAnswer'];
    final isCorrect = index == currentQuestion['correctIndex'];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Center(
          child: Text(
            option,
            style: TextStyle(
              fontSize: 14.0,
              color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.black45,
            ),
          ),
        ),
        onTap: () {
          final correctIndex = currentQuestion['correctIndex'] as int;
          final isCorrect = index == correctIndex;

          setState(() {
            currentQuestion['selectedAnswer'] = index;
          });

          final feedback = isCorrect ? 'Correct!' : 'Incorrect. Try again.';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(feedback),
              duration: Duration(seconds: 2),
              backgroundColor: isCorrect ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuizView() {
    return Column(
      children: [
        _buildCenteredText('${currentQuestionIndex + 1}/$questionCount', TextStyle(fontSize: 16.0)),
        _buildQuestionAndOptions(),
      ],
    );
  }

  Widget _buildButtonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
              });
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            if (currentQuestionIndex < questionCount - 1) {
              setState(() {
                currentQuestionIndex++;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildAnswer() {
    final currentQuestion = quizData[currentQuestionIndex];
    final selectedAnswer = currentQuestion['selectedAnswer'] as int;

    return _buildCenteredText(
      selectedAnswer == -1
          ? 'Select an answer'
          : 'Selected Answer: ${currentQuestion['options'][selectedAnswer]}',
      TextStyle(fontSize: 16.0),
    );
  }
}
