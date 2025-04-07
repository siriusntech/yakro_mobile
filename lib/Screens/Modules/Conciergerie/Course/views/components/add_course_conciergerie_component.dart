import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddCourseConciergerieComponent extends StatefulWidget {
  const AddCourseConciergerieComponent({super.key});

  @override
  State<AddCourseConciergerieComponent> createState() =>
      _AddCourseConciergerieComponentState();
}

class _AddCourseConciergerieComponentState
    extends State<AddCourseConciergerieComponent> {
  final controllerCourseConciergerie =
  Get.find<CourseConciergerieScreenController>();

  final ScrollController _scrollController = ScrollController(); // Add ScrollController

  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = []; // Add FocusNode list
  List<Widget> _textFields = [];

  void _addTextField() {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode(); // Create a FocusNode
    _controllers.add(controller);
    _focusNodes.add(focusNode); // Add the FocusNode

    final index = _textFields.length; // Get the index before adding the widget
    _textFields.add(_buildTextField(controller, focusNode, index)); // Pass the focusNode

    // Add listener to the new focus node to scroll when it gets focus
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _scrollToIndex(index);
      }
    });

    setState(() {});
  }

  void _removeTextField(int index) {
    if (index >= 0 && index < _controllers.length) {
      _controllers[index].dispose();
      _focusNodes[index].dispose(); // Dispose and remove FocusNode
      _controllers.removeAt(index);
      _focusNodes.removeAt(index);
      _textFields.removeAt(index);
      setState(() {});
    } else {
      // Clear all if index is invalid (handles potential issues)
      for (var controller in _controllers) {
        controller.dispose();
      }
      for (var focusNode in _focusNodes) {
        focusNode.dispose();
      }
      _controllers.clear();
      _focusNodes.clear();
      _textFields.clear();
      setState(() {});
    }
  }

  Widget _buildTextField(TextEditingController controllerText, FocusNode focusNode, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllerText,
              focusNode: focusNode, // Assign the focus node
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Tache ${index + 1}',
                labelStyle: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: controllerCourseConciergerie.colorPrimary.value),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: controllerCourseConciergerie.colorPrimary.value),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: controllerCourseConciergerie.colorPrimary.value,
                      width: 2.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () => _removeTextField(index),
          ),
        ],
      ),
    );
  }

  void _scrollToIndex(int index) {
    // Ensure the ListView has been built and the item exists
    if (_scrollController.hasClients && index < _textFields.length) {
      // This is a simplified scroll calculation.
      // Adjust itemHeight if your TextField items have significant vertical padding or margins.
      const double itemHeight = 100.0; // Approximate height of a TextField item

      // Calculate the position to scroll to. We scroll to the top of the item.
      final double position = index * itemHeight;

      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) { // Dispose focus nodes
      focusNode.dispose();
    }
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _addTextField(); // Add the first TextField and its listener
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              'Creer une Course',
              style: GoogleFonts.taprom(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Text(
              'Pour chaque Tache soyez le plus precis possible',
              style: GoogleFonts.nunito(
                  fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Attach the scroll controller
                itemCount: _textFields.length,
                itemBuilder: (context, index) => _textFields[index],
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        quickAlertDialog(context, QuickAlertType.loading,
                            color:
                            controllerCourseConciergerie.colorPrimary.value,
                            title: 'Veuillez patientez...',
                            message: 'Traitement en cours');
                        Future.delayed(const Duration(seconds: 3), () {
                          Get.back();
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => RecapCourseComponent(
                                controllers: _controllers,
                              ));
                        });
                        controllerCourseConciergerie
                            .parseTextEditindInputInMap(_controllers);
                      },
                      child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                          child: Text(
                            'Validez',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 20),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  ElevatedButton(
                    onPressed: _addTextField,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          controllerCourseConciergerie.colorPrimary.value),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}