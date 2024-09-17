import 'package:flutter/material.dart';

import '../../../../../core/utils/icons/konsi_icons.dart';
import '../selected_bottom_navigation_icon_widget.dart';

class OutletBottomNavigationBarWidget extends StatelessWidget {
  const OutletBottomNavigationBarWidget({
    super.key,
    required this.onDestinationSelected,
    required this.currentIndex,
  });

  final Function(int index) onDestinationSelected;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE8E8E8).withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        onTap: (index) => onDestinationSelected(index),
        items: [
          const BottomNavigationBarItem(
            activeIcon: SelectedBottomNavigationIconWidget(
              icon: Icon(
                KonsiIcons.map,
              ),
            ),
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(KonsiIcons.map),
            ),
            label: 'Mapa',
          ),
          const BottomNavigationBarItem(
            label: 'Caderneta',
            activeIcon: SelectedBottomNavigationIconWidget(
              icon: Icon(KonsiIcons.notebook),
            ),
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(KonsiIcons.notebook),
            ),
          ),
        ],
      ),
    );
  }
}
