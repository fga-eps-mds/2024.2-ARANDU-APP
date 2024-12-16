import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  final String title;
  final List<ProfileLinkItem> items;

  const ProfileSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final Map<int, bool> switchStates = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      switchStates[i] = widget.items[i].switchValue ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...widget.items.map((item) {
            int index = widget.items.indexOf(item);
            return Column(
              children: [
                _buildMenuItem(context, item, index),
                if (index < widget.items.length - 1)
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, ProfileLinkItem item, int index) {
    return ListTile(
      leading: Icon(
        item.icon,
        color: Colors.orange,
      ),
      title: Text(
        item.name,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: item.hasSwitch
          ? Switch(
              value: switchStates[index]!,
              onChanged: (value) {
                setState(() {
                  switchStates[index] = value;
                });
                if (item.onSwitchChanged != null) {
                  item.onSwitchChanged!(value);
                }
              },
              activeColor: Colors.white,
            )
          : IconButton(
              icon: const Icon(Icons.chevron_right),
              color: Colors.black,
              onPressed: item.onTap,
            ),
      onTap: item.onTap,
    );
  }
}

class ProfileLinkItem {
  final IconData icon;
  final String name;
  final VoidCallback? onTap;
  final bool hasSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  ProfileLinkItem({
    required this.icon,
    required this.name,
    this.onTap,
    this.hasSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
  });
}
