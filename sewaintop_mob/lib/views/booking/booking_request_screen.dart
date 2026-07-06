// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_state.dart';
import 'package:sewaintop_mob/blocs/booking/booking_bloc.dart';
import 'package:sewaintop_mob/blocs/booking/booking_event.dart';
import 'package:sewaintop_mob/blocs/booking/booking_state.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/models/booking_model.dart';
import 'package:sewaintop_mob/views/booking/booking_success_screen.dart'; // Import success screen

class BookingRequestScreen extends StatefulWidget {
  final Laptop laptop;

  const BookingRequestScreen({super.key, required this.laptop});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  
  // Initial date selection to match June 15 - June 19, 2026 (avoiding blocked day 20)
  DateTime _startDate = DateTime(2026, 6, 15);
  DateTime _endDate = DateTime(2026, 6, 19);

  final TextEditingController _notesController = TextEditingController();

  // Unavailable/Blocked dates for June 2026 (matching previous screen & screenshot)
  final Set<int> _blockedDays = {10, 11, 12, 13, 14, 20, 21, 22};

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  int _calculateDuration() {
    return _endDate.difference(_startDate).inDays;
  }

  double _calculateTotal() {
    final days = _calculateDuration();
    return days * widget.laptop.priceNumeric;
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatRupiah(double value) {
    final intVal = value.round();
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

  bool rangeContainsBlockedDays(DateTime start, DateTime end) {
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (current.month == 6 && _blockedDays.contains(current.day)) {
        return true;
      }
      current = current.add(const Duration(days: 1));
    }
    return false;
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2026, 6, 1),
      lastDate: DateTime(2026, 6, 30),
      selectableDayPredicate: (day) => !_blockedDays.contains(day.day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          final tentativeStart = picked;
          if (rangeContainsBlockedDays(tentativeStart, _endDate) || tentativeStart.isAfter(_endDate)) {
            _startDate = tentativeStart;
            _endDate = tentativeStart;
          } else {
            _startDate = tentativeStart;
          }
        } else {
          final tentativeEnd = picked;
          if (rangeContainsBlockedDays(_startDate, tentativeEnd) || tentativeEnd.isBefore(_startDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Rentang tanggal melewati tanggal yang sudah dibooking!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            _startDate = tentativeEnd;
            _endDate = tentativeEnd;
          } else {
            _endDate = tentativeEnd;
          }
        }
      });
    }
  }

  void _onDayTapped(int day) {
    if (_blockedDays.contains(day)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal ini sudah dibooking orang lain.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final tappedDate = DateTime(2026, 6, day);

    setState(() {
      if (tappedDate.isAfter(_startDate)) {
        if (rangeContainsBlockedDays(_startDate, tappedDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rentang tanggal melewati tanggal yang sudah dibooking!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          _startDate = tappedDate;
          _endDate = tappedDate;
        } else {
          _endDate = tappedDate;
        }
      } else {
        _startDate = tappedDate;
        _endDate = tappedDate;
      }
    });
  }

  void _submitRequest() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus masuk terlebih dahulu.')),
      );
      return;
    }

    final duration = _calculateDuration();
    final total = _calculateTotal();

    final booking = Booking(
      id: 0,
      userId: authState.user.id,
      laptopId: widget.laptop.id,
      laptopTitle: widget.laptop.title,
      laptopImage: widget.laptop.imageUrl,
      startDate: _startDate.toIso8601String().split('T').first,
      endDate: _endDate.toIso8601String().split('T').first,
      duration: duration,
      pricePerDay: widget.laptop.priceNumeric,
      totalPrice: total,
      status: 'active',
      notes: _notesController.text.trim(),
      shopName: widget.laptop.shopName,
      createdAt: DateTime.now().toIso8601String(),
    );

    context.read<BookingBloc>().add(CreateBooking(booking: booking));
  }

  @override
  Widget build(BuildContext context) {
    final laptop = widget.laptop;
    final duration = _calculateDuration();
    final total = _calculateTotal();

    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingCreatedSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookingSuccessScreen(
                laptop: widget.laptop,
                startDate: _startDate,
                endDate: _endDate,
                duration: duration,
                total: total,
              ),
            ),
          );
        } else if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buat Permintaan Sewa',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildStepper(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Laptop Summary Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder, width: 1),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 64,
                            height: 54,
                            child: Image.network(
                              laptop.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade100,
                                child: const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                laptop.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                laptop.price,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. Pilih Tanggal Sewa Header
                  const Text(
                    'Pilih Tanggal Sewa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Mulai / Selesai Picker Boxes
                  Row(
                    children: [
                      _buildDateDisplayBox('Mulai', _startDate, true),
                      const SizedBox(width: 12),
                      _buildDateDisplayBox('Selesai', _endDate, false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Calendar Widget
                  _buildPickerCalendar(),
                  const SizedBox(height: 24),

                  // 3. Pricing Breakdown Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder, width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Durasi',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                            ),
                            Text(
                              '$duration hari',
                              style: const TextStyle(
                                color: AppColors.textDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Harga/hari',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                            ),
                            Text(
                              _formatRupiah(laptop.priceNumeric),
                              style: const TextStyle(
                                color: AppColors.textDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: AppColors.cardBorder),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TOTAL',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              _formatRupiah(total),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. Catatan Owner Optional Field
                  const Text(
                    'Catatan untuk pemilik (opsional)',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Contoh: perlu tas laptop, power adapter tambahan...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.cardBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.cardBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  final isLoading = state is BookingLoading;
                  return ElevatedButton(
                    onPressed: isLoading ? null : _submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Kirim Permintaan Sewa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepItem(1, 'Tanggal', true),
        _buildStepLine(),
        _buildStepItem(2, 'Ringkasan', false),
        _buildStepLine(),
        _buildStepItem(3, 'Konfirmasi', false),
      ],
    );
  }

  Widget _buildStepItem(int stepNumber, String label, bool isActive) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.cardBorder,
              width: 1.5,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textMuted,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 24,
      height: 1,
      color: AppColors.cardBorder,
    );
  }

  Widget _buildDateDisplayBox(String label, DateTime date, bool isStart) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectDate(context, isStart),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(date),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerCalendar() {
    final List<String> weekdays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    final List<int> days = List.generate(27, (index) => index + 1); // 27 days shown in June screenshot

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left, size: 20),
                onPressed: () {},
              ),
              const Text(
                'Juni 2026',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Weekdays
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 32,
                child: Text(
                  day,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Days Grid (starts on Sunday = Min)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 28, // 4 rows x 7 columns
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index >= days.length) {
                return const SizedBox();
              }
              final day = days[index];
              final date = DateTime(2026, 6, day);

              final isBlocked = _blockedDays.contains(day);
              final isStart = date.year == _startDate.year &&
                  date.month == _startDate.month &&
                  date.day == _startDate.day;
              final isEnd = date.year == _endDate.year &&
                  date.month == _endDate.month &&
                  date.day == _endDate.day;
              final inRange = date.isAfter(_startDate) && date.isBefore(_endDate);

              return GestureDetector(
                onTap: () => _onDayTapped(day),
                child: Container(
                  decoration: BoxDecoration(
                    color: isBlocked
                        ? const Color(0xFFFEF2F2)
                        : (isStart || isEnd
                            ? AppColors.primary
                            : (inRange ? AppColors.primary.withOpacity(0.12) : null)),
                    shape: isStart || isEnd ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: isStart || isEnd
                        ? null
                        : (isBlocked 
                            ? BorderRadius.circular(8) 
                            : (inRange ? BorderRadius.circular(4) : null)),
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: (isStart || isEnd || inRange || isBlocked)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isBlocked
                            ? const Color(0xFFEF4444)
                            : (isStart || isEnd
                                ? Colors.white
                                : (inRange ? AppColors.primary : AppColors.textDark)),
                        decoration: isBlocked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
