// class AutoSlidePageView extends StatelessWidget {
//   final int _numPages = 3;
//   final int _autoSlideDuration = 3000;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200, // Adjust the height as needed
//       child: AutoAnimatedPageView(
//         itemCount: _numPages,
//         itemBuilder: (context, index, percentVisible) {
//           return Container(
//             color: index % 2 == 0 ? Colors.blue : Colors.green,
//             child: Center(
//               child: Text(
//                 'Page ${index + 1}',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//             ),
//           );
//         },
//         interval: Duration(milliseconds: _autoSlideDuration),
//       ),
//     );
//   }
// }