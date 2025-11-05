import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/colors/theme_notifier.dart';
import 'package:provider/provider.dart';

class LimitSelectorCard extends StatelessWidget {
  final int?
  currentLimit; // puede ser null si aún no hay datos para cambiar la longitud de la lista
  final List<int> limitOptions;
  final ValueChanged<int> onChanged;
  final Size size;
  const LimitSelectorCard({
    super.key,

    required this.currentLimit,
    required this.limitOptions,
    required this.onChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsetsGeometry.only(top: size.shortestSide / 32),
      child: SizedBox(
        width: size.width,
        child: Card(
          elevation: 2,
          color: themeNotifier.isDarkMode ? kPrimaryColor : kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: size.shortestSide / 16,
                  height: size.shortestSide / 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.hashtag,
                      color: !themeNotifier.isDarkMode
                          ? colorsWhite
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Cambiar numeros de perros mostrados",
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: themeNotifier.isDarkMode
                              ? Colors.black
                              : colorsWhite,
                          borderRadius: BorderRadius.circular(24),
                          //      border: Border.all(color: borderColor),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () => FocusScope.of(
                            context,
                          ).unfocus(), // cerramos el teclado para que no estorbe
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: currentLimit,
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.listOl,

                                    color: themeNotifier.isDarkMode
                                        ? colorsWhite
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      color: themeNotifier.isDarkMode
                                          ? colorsWhite
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              icon: const Icon(FontAwesomeIcons.chevronDown),
                              borderRadius: BorderRadius.circular(12),
                              style: textTheme.bodyMedium,
                              items: limitOptions
                                  .map(
                                    (v) => DropdownMenuItem<int>(
                                      value: v,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Spacer(flex: 1),
                                          Icon(
                                            FontAwesomeIcons.listOl,

                                            color: themeNotifier.isDarkMode
                                                ? colorsWhite
                                                : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              v.toString(),
                                              style: TextStyle(
                                                color: themeNotifier.isDarkMode
                                                    ? colorsWhite
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                onChanged(value); // delega al padre
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
