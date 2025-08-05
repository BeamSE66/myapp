import 'package:flutter/material.dart';

void main() => runApp(MyDemoApp());

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.teal, // สีหลักของแอป
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[700], // สี AppBar
          foregroundColor: Colors.white, // สีตัวอักษรบน AppBar
        ),
      ),
      title: 'My Academic Portfolio',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, Widget page, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // สีพื้นหลังปุ่ม
          foregroundColor: Colors.white, // สีตัวอักษร
          minimumSize: Size(double.infinity, 60), // ขนาดปุ่ม
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // ขอบมน
          ),
          elevation: 5, // เงา
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _navigate(context, page),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio ของฉัน'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildMenuItem(context, 'ผลการเรียน: เทอม 1', SemesterPage(semester: 1), Colors.blueGrey),
              _buildMenuItem(context, 'ผลการเรียน: เทอม 2', SemesterPage(semester: 2), Colors.blueGrey),
              _buildMenuItem(context, 'ผลการเรียน: เทอม 3', SemesterPage(semester: 3), Colors.blueGrey),
              _buildMenuItem(context, 'ผลการเรียน: เทอม 4', SemesterPage(semester: 4), Colors.blueGrey),
              _buildMenuItem(context, 'ผลการเรียน: เทอม 5', SemesterPage(semester: 5), Colors.blueGrey),
              SizedBox(height: 20),
              _buildMenuItem(context, 'ผลลัพธ์การเรียนรู้', LearningOutcomesPage(), Colors.orange),
              _buildMenuItem(context, 'ข้อมูลส่วนตัว', ProfilePage(), Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}

// --- หน้าแสดงผลการเรียน (Semester Pages) ---
class SemesterPage extends StatelessWidget {
  final int semester;
  const SemesterPage({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    // ข้อมูลสมมติสำหรับแต่ละเทอม
    Map<int, List<Map<String, String>>> semesterData = {
      1: [
        {'code': 'CS101', 'name': 'Intro to Programming', 'grade': 'A'},
        {'code': 'MA101', 'name': 'Calculus I', 'grade': 'B+'},
        {'code': 'EN101', 'name': 'English I', 'grade': 'A-'},
      ],
      2: [
        {'code': 'CS102', 'name': 'Data Structures', 'grade': 'B'},
        {'code': 'MA102', 'name': 'Calculus II', 'grade': 'A'},
        {'code': 'PH101', 'name': 'Physics I', 'grade': 'C+'},
      ],
      3: [
        {'code': 'CS201', 'name': 'Algorithms', 'grade': 'A'},
        {'code': 'DB201', 'name': 'Database Systems', 'grade': 'B+'},
        {'code': 'OS201', 'name': 'Operating Systems', 'grade': 'B'},
      ],
      4: [
        {'code': 'SE301', 'name': 'Software Engineering', 'grade': 'A-'},
        {'code': 'NW301', 'name': 'Computer Networks', 'grade': 'B+'},
        {'code': 'AI301', 'name': 'Artificial Intelligence', 'grade': 'A'},
      ],
      5: [
        {'code': 'WD401', 'name': 'Web Development', 'grade': 'A'},
        {'code': 'ML401', 'name': 'Machine Learning', 'grade': 'A-'},
        {'code': 'PR499', 'name': 'Project', 'grade': 'B+'},
      ],
    };

    List<Map<String, String>> currentSemesterCourses = semesterData[semester] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการเรียน: เทอม $semester'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'รายวิชาและผลการเรียนในเทอม $semester:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 15),
              Expanded(
                child: currentSemesterCourses.isEmpty
                    ? Center(child: Text('ไม่มีข้อมูลสำหรับเทอมนี้'))
                    : ListView.builder(
                        itemCount: currentSemesterCourses.length,
                        itemBuilder: (context, index) {
                          final course = currentSemesterCourses[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รหัสวิชา: ${course['code']}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'ชื่อวิชา: ${course['name']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'เกรด: ${course['grade']}',
                                    style: TextStyle(fontSize: 16, color: Colors.green[700]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  label: Text('กลับสู่หน้าหลัก'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- หน้าแสดงผลลัพธ์การเรียนรู้ (Learning Outcomes) ---
class LearningOutcomesPage extends StatelessWidget {
  const LearningOutcomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์การเรียนรู้'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'หลังจากการเรียนรู้ในแต่ละปี ฉันได้รับความรู้และสามารถทำสิ่งเหล่านี้ได้:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[800]),
              ),
              SizedBox(height: 15),
              _buildOutcomeCard(
                'ปีที่ 1: พื้นฐานการเขียนโปรแกรม',
                'สามารถเขียนโปรแกรมเบื้องต้นด้วยภาษา Dart/Python เข้าใจโครงสร้างข้อมูลพื้นฐาน และแก้ปัญหาเชิงตรรกะได้',
              ),
              _buildOutcomeCard(
                'ปีที่ 2: โครงสร้างข้อมูลและอัลกอริทึม',
                'เข้าใจและประยุกต์ใช้โครงสร้างข้อมูลและอัลกอริทึมที่ซับซ้อนขึ้นได้ ออกแบบและวิเคราะห์ประสิทธิภาพของโปรแกรม',
              ),
              _buildOutcomeCard(
                'ปีที่ 3: การพัฒนาระบบและฐานข้อมูล',
                'พัฒนาแอปพลิเคชันที่มีระบบฐานข้อมูลได้ ออกแบบและจัดการฐานข้อมูลเชิงสัมพันธ์ รวมถึงเข้าใจหลักการของระบบปฏิบัติการ',
              ),
              _buildOutcomeCard(
                'ปีที่ 4: ปัญญาประดิษฐ์และโครงข่าย',
                'มีความรู้พื้นฐานด้าน AI และ Machine Learning สามารถสร้างโมเดลเบื้องต้นได้ และเข้าใจหลักการทำงานของเครือข่ายคอมพิวเตอร์',
              ),
              _buildOutcomeCard(
                'ปีที่ 5: การพัฒนาเว็บและโครงการ',
                'สามารถพัฒนาเว็บแอปพลิเคชันแบบครบวงจร (Full-stack) และนำความรู้ที่เรียนมาประยุกต์ใช้ในโครงการจริง',
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  label: Text('กลับสู่หน้าหลัก'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutcomeCard(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[700]),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// --- หน้าโปรไฟล์ส่วนตัว (Profile Page) ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // แทนที่ด้วย URL รูปภาพของคุณ
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              SizedBox(height: 20),
              _buildProfileDetail('ชื่อ-นามสกุล', 'ชื่อของคุณ นามสกุลของคุณ'),
              _buildProfileDetail('วันเกิด', 'XX มกราคม XXXX'),
              _buildProfileDetail('อีเมล', 'your.email@example.com'),
              _buildProfileDetail('ความชอบ', 'อ่านหนังสือ, เล่นเกม, เขียนโค้ด'),
              _buildProfileDetail('ความถนัด', 'การวิเคราะห์ข้อมูล, การออกแบบ UI/UX'),
              _buildProfileDetail('ความสามารถพิเศษ', 'เล่นดนตรี, พูดได้หลายภาษา'),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  label: Text('กลับสู่หน้าหลัก'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}