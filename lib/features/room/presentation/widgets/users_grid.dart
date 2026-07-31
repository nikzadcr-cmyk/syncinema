import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/colors.dart';
import '../../domain/entities/room.dart';

class UsersGrid extends StatelessWidget {
  final List<User> users;
  final String? currentUserId;
  final bool isHost;
  final void Function(String userId) onTransferHost;
  const UsersGrid({super.key, required this.users, this.currentUserId, required this.isHost, required this.onTransferHost});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: users.map((u) => _UserChip(user: u, isMe: u.id == currentUserId, isHost: isHost, onTransfer: () => onTransferHost(u.id))).toList(),
    );
  }
}

class _UserChip extends StatelessWidget {
  final User user;
  final bool isMe;
  final bool isHost;
  final VoidCallback onTransfer;
  const _UserChip({required this.user, required this.isMe, required this.isHost, required this.onTransfer});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isMe ? AppColors.primary.withOpacity(0.3) : Colors.white.withOpacity(0.06)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: AppColors.surfaceDark3, child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700))),
                  if (user.isHost)
                    Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.accentOrange, shape: BoxShape.circle, border: Border.all(color: AppColors.surfaceDark, width: 1.5)), child: const Icon(Icons.star_rounded, size: 8, color: Colors.white))),
                ],
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(user.name, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                      if (isMe) ...[const Gap(4), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)), child: const Text('شما', style: TextStyle(fontSize: 9, color: Colors.white)))],
                    ],
                  ),
                  Row(
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                      const Gap(4),
                      Text('${user.pingMs}ms', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondaryDark, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              if (isHost && !isMe && !user.isHost) ...[
                const Gap(8),
                InkWell(
                  onTap: onTransfer,
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: const Text('Host', style: TextStyle(fontSize: 10))),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
