import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class ModuleCard extends StatefulWidget {
  final String chapter;
  final String titleModule;
  final bool isTeacher;
  final bool isClicked;
  final Function() onTap;
  const ModuleCard({
    super.key,
    required this.chapter,
    required this.titleModule,
    this.isTeacher = false,
    required this.onTap,
    required this.isClicked,
  });

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryOfWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          border: Border.all(
            width: 2,
            color: const Color(0xffD8D8D8),
          ),
        ),
        child: widget.titleModule != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chapter,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: secondaryColor, fontWeight: medium),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: mediaQueryOfWidth * .6,
                        child: Text(
                          widget.titleModule,
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  widget.isTeacher
                      ? DottedBorder(
                          dashPattern: const [5, 6],
                          strokeCap: StrokeCap.round,
                          color: widget.isClicked ? greenColor : secondaryColor,
                          strokeWidth: 2,
                          borderType: BorderType.Oval,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: widget.isClicked
                                ? Icon(Icons.check,
                                    color: widget.isClicked
                                        ? greenColor
                                        : secondaryColor)
                                : const SizedBox(),
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            : Text(
                'Module ${widget.chapter}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: secondaryColor, fontWeight: medium),
              ),
      ),
    );
  }
}
