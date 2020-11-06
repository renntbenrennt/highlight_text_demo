# Flutter highlight text demo

This demo is based on @Jaime's selection example with my modification on his rendering text logic.

Demo:

![highlight_text_demo](https://user-images.githubusercontent.com/13610283/98333107-f8d78d00-203a-11eb-8880-e6c73d115844.gif)

I know there might be a better way to achieve such feature considering mine's operate the text on a character level...

and convert each single character into TextSpan, which might cause space waste? I guess?

But in my investigation, I found that Flutter engine is actually turning all the TextSpan into the String text of the EditableText on rendering...

So... that space waste might not actually happen?

I need to dig deeper into the source code...

So far, there's two known issues I think it's due to the fact that the Flutter still has room to improve

1. TextSelection is inaccurate(baseOffset and extentOffset) when there's emoji involved
2. Selection background's height will be inconsistent between Chinese and English, which I have opened an issue for that, I hope I will have the energy to open PR for it, I'm so depressed by my life right now😢...
