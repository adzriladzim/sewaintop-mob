// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';

class FilterCriteria {
  final String? category;
  final String? ram;
  final String? processor;
  final RangeValues priceRange;
  final bool availableOnly;

  FilterCriteria({
    this.category,
    this.ram,
    this.processor,
    required this.priceRange,
    required this.availableOnly,
  });
}

class FilterBottomSheet extends StatefulWidget {
  final FilterCriteria initialCriteria;
  final int totalMatchCount; // Dynamically pass or compute match count

  const FilterBottomSheet({
    super.key,
    required this.initialCriteria,
    required this.totalMatchCount,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedCategory;
  String? _selectedRam;
  String? _selectedProcessor;
  late RangeValues _currentRangeValues;
  late bool _availableOnly;

  final List<String> _categories = ['Gaming', 'Office', 'Design', 'Video Editing'];
  final List<String> _ramOptions = ['4GB', '8GB', '16GB', '32GB'];
  final List<String> _processors = ['Intel Core', 'AMD Ryzen', 'Apple M-series'];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCriteria.category;
    _selectedRam = widget.initialCriteria.ram;
    _selectedProcessor = widget.initialCriteria.processor;
    _currentRangeValues = widget.initialCriteria.priceRange;
    _availableOnly = widget.initialCriteria.availableOnly;
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedRam = null;
      _selectedProcessor = null;
      _currentRangeValues = const RangeValues(100000, 300000);
      _availableOnly = true;
    });
  }

  String _formatRupiah(double value) {
    final intVal = value.round();
    if (intVal >= 1000000) {
      double millionVal = intVal / 1000000;
      return 'Rp ${millionVal.toStringAsFixed(1).replaceAll('.0', '')}jt';
    }
    // Simple thousands separator for formatting
    String str = intVal.toString();
    String result = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      count++;
      if (count == 3 && i > 0) {
        result = '.$result';
        count = 0;
      }
    }
    return 'Rp $result';
  }

  // Calculate a simulated match count based on selected filters to make UI feel alive
  int _calculateSimulatedMatches() {
    int base = 24;
    if (_selectedCategory != null) base -= 5;
    if (_selectedRam != null) base -= 4;
    if (_selectedProcessor != null) base -= 6;
    if (_availableOnly) base -= 3;
    
    // factor price range
    final rangeDiff = _currentRangeValues.end - _currentRangeValues.start;
    if (rangeDiff < 200000) {
      base -= 4;
    } else if (rangeDiff < 100000) {
      base -= 8;
    }
    
    if (base < 1) base = 1; // minimum 1 matching
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final matches = _calculateSimulatedMatches();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle indicator
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header: Filter Laptop & Reset Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Laptop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                GestureDetector(
                  onTap: _resetFilters,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.cardBorder),

          // Scrollable filter selections
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Kategori Section
                  _buildSectionTitle('Kategori'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return _buildSelectableChip(
                        label: cat,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedCategory = isSelected ? null : cat;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // 2. RAM Section
                  _buildSectionTitle('RAM'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _ramOptions.map((ram) {
                      final isSelected = _selectedRam == ram;
                      return _buildSelectableChip(
                        label: ram,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedRam = isSelected ? null : ram;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // 3. Prosesor Section
                  _buildSectionTitle('Prosesor'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _processors.map((proc) {
                      final isSelected = _selectedProcessor == proc;
                      return _buildSelectableChip(
                        label: proc,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedProcessor = isSelected ? null : proc;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 4. Harga per Hari Section
                  _buildSectionTitle('Harga per Hari'),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '${_formatRupiah(_currentRangeValues.start)} – ${_formatRupiah(_currentRangeValues.end)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 50000,
                    max: 500000,
                    divisions: 45, // intervals of 10.000
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.cardBorder,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // 5. Ketersediaan Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tersedia saja',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      Switch(
                        value: _availableOnly,
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: Colors.grey.shade200,
                        onChanged: (bool value) {
                          setState(() {
                            _availableOnly = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: AppColors.cardBorder),
          const SizedBox(height: 16),

          // Footer Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                // Outline Reset Button
                Expanded(
                  flex: 3,
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textMuted,
                      side: const BorderSide(color: AppColors.cardBorder, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Solid Terapkan Filter Button
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      final criteria = FilterCriteria(
                        category: _selectedCategory,
                        ram: _selectedRam,
                        processor: _selectedProcessor,
                        priceRange: _currentRangeValues,
                        availableOnly: _availableOnly,
                      );
                      Navigator.pop(context, criteria);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Terapkan Filter',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            matches.toString(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildSelectableChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
