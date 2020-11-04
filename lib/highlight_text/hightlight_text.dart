import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:text_span_thousands/highlight_text/lib/cupertino/cupertino_selection_handle.dart';
import 'package:text_span_thousands/highlight_text/lib/material/material_selection_controllers.dart';
import 'package:text_span_thousands/highlight_text/lib/text_selection_controls.dart';

class RichTextController extends ChangeNotifier {
  List<TextSpan> _source;

  /// containing the user selection
  List<TextSelection> _selected = [];

  List<List<TextSpan>> selectedText = [];

  RichTextController(this._source);

  /// call when user choose highlight from the menu
  void addSelection(TextSelection selection) {
    _selected.add(selection);
    getSourceAfterSelected();
    notifyListeners();
  }

  void getSourceAfterSelected() {
    // 1. make a empty variable, which will be returned after the manipulation
    List<TextSpan> res = [];

    // 2. begin the manipulation...
    // 2.1. because we can just directly manipulate the source, we'd better made a copy of it
    res.addAll(_source);

    // 2.2 change the part of the source where it's selected(based on _selected)
    final newestSelection = _selected.last;
    int loopStart = newestSelection.baseOffset;
    int loopEnd = newestSelection.extentOffset;

    for (int highlightIndex = loopStart;
        highlightIndex < loopEnd;
        highlightIndex++) {
      //TODO find out why this doesn't work as expected
      // res[highlightIndex].style.copyWith(backgroundColor: Colors.amberAccent);
      res[highlightIndex] = TextSpan(
        text: res[highlightIndex].text,
        style: TextStyle(
          fontWeight: res[highlightIndex].style?.fontWeight,
          fontStyle: res[highlightIndex].style?.fontStyle,
          backgroundColor: Colors.amberAccent,
        ),
      );
    }

    //TODO 3. set the result
    _source = res;
  }

  List<TextSpan> get renderingData => _source;
}

class HighlightText extends StatefulWidget {
  final List<TextSpan> spans;

  const HighlightText({Key key, this.spans}) : super(key: key);

  @override
  _HighlightTextState createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  RichTextController richTextController;

  List<TextSelectionToolbarItem> selectionToolBarItems;

  FocusNode _focusNode;

  @override
  void initState() {
    richTextController = RichTextController(widget.spans);

    richTextController.addListener(updateRichText);

    selectionToolBarItems = [
      TextSelectionToolbarItem(
        onPressed: (selectionController) {
          final selection = selectionController.selection;

          print('baseOffset = ${selection.baseOffset}');
          print('extentOffset = ${selection.extentOffset}');

          richTextController.addSelection(selection);
        },
        title: Text('Highlight'),
      ),
      TextSelectionToolbarItem.copy(),
    ];

    _focusNode = FocusNode();

    super.initState();
  }

  updateRichText() {
    setState(() {
      // Notify rich text changes
    });
  }

  @override
  void didUpdateWidget(HighlightText oldWidget) {
    super.didUpdateWidget(oldWidget);

    //TODO: ASK @Jaime what this does
    if (widget.spans != oldWidget.spans) {
      // richTextController.removeListener(updateRichText);
      // richTextController.dispose();

      //TODO: ...find a way to resolve this
      // richTextController = RichTextController(widget.text);
      // richTextController.addListener(updateRichText);
    }
  }

  @override
  void dispose() {
    richTextController.removeListener(updateRichText);
    richTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(children: richTextController.renderingData),
      cursorColor: Colors.black,
      toolbarOptions: ToolbarOptions(copy: true),
      selectionControls: DefaultTextSelectionControls(
        handle: CupertinoTextSelectionHandle(color: Colors.black),
        toolbar: MaterialSelectionToolbar(
          items: selectionToolBarItems,
          theme: ThemeData.dark(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      focusNode: _focusNode,
      onTap: () {
        print('focusNode stuff ${_focusNode.context.widget}');
      },
    );
  }
}
