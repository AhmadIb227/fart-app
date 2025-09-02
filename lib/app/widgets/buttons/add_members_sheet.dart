import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/widgets/inputs/gradient_checkbox.dart';

import '../../core/theme/app_colors.dart';
import '../../core/values/strings.dart';
import '../../data/models/contact_user.dart';

/// استدعِ هذه الدالة من الكونترولر
Future<List<ContactUser>?> showAddMembersSheet({
  required List<ContactUser> all,
  required List<ContactUser> initiallySelected,
}) {
  return Get.bottomSheet<List<ContactUser>>(
    AddMembersSheet(all: all, initiallySelected: initiallySelected),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class AddMembersSheet extends StatefulWidget {
  final List<ContactUser> all;
  final List<ContactUser> initiallySelected;
  const AddMembersSheet({
    super.key,
    required this.all,
    required this.initiallySelected,
  });

  @override
  State<AddMembersSheet> createState() => _AddMembersSheetState();
}

class _AddMembersSheetState extends State<AddMembersSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  late List<ContactUser> _filtered;
  late Set<String> _selectedPhones;

  @override
  void initState() {
    super.initState();
    _filtered = widget.all;
    _selectedPhones = widget.initiallySelected.map((m) => m.phone).toSet();
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = widget.all;
      } else {
        _filtered = widget.all.where((m) {
          final n = m.name.toLowerCase();
          final p = m.phone.toLowerCase();
          return n.contains(q) || p.contains(q);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height * .80;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxH),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color(0x100D0A2C),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  AppStrings.addMembersToGroup,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // Poppins/Medium 16
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF292929),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // حقل البحث
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD0D1DB), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 24,
                      color: Color(0xFF2C2D3A),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchCtrl,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: AppStrings.search,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF2C2D3A).withOpacity(.30),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2C2D3A),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // القائمة
              Expanded(
                child: ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 24),
                  itemBuilder: (context, i) {
                    final m = _filtered[i];
                    final selected = _selectedPhones.contains(m.phone);
                    return _ContactRow(
                      name: m.name,
                      phone: m.phone,
                      selected: selected,
                      onToggle: () {
                        setState(() {
                          if (selected) {
                            _selectedPhones.remove(m.phone);
                          } else {
                            _selectedPhones.add(m.phone);
                          }
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // أزرار الإجراء
              Row(
                children: [
                  // Add
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            final picked = widget.all
                                .where((m) => _selectedPhones.contains(m.phone))
                                .toList();
                            Get.back(result: picked);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: AppColors.greenGradient,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                AppStrings.add,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),

                  // Cancel
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFD0D1DB),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color(0xFFEFEFEF),
                        ),
                        onPressed: () => Get.back(),
                        child: const Text(
                          AppStrings.cancel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String name;
  final String phone;
  final bool selected;
  final VoidCallback onToggle;

  const _ContactRow({
    required this.name,
    required this.phone,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientCheckbox(
          value: selected,
          onChanged: (_) => onToggle(),
          size: 24,
          borderWidth: 2,
          borderRadius: 6,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2C2D3A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                phone,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9A9BB1),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
