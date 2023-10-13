import 'package:flutter/material.dart';
import 'package:loading_anim/components/shimmer_loading/card_list_item.dart';
import 'package:loading_anim/components/shimmer_loading/circle_list_item.dart';
import 'package:loading_anim/components/shimmer_loading/shimmer.dart';

import 'shimmer_loading.dart';

class ShimmerView extends StatefulWidget {
  const ShimmerView({super.key});

  @override
  State<ShimmerView> createState() => _ShimmerViewState();
}

class _ShimmerViewState extends State<ShimmerView> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer View'),
      ),
      body: SingleChildScrollView(
        child: Shimmer(
          linearGradient: shimmerGradient,
          child: Column(
            children: [
              SizedBox(
                height: 62,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ShimmerLoading(
                      isLoading: _isLoading,
                      child: const CircleListItem(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ShimmerLoading(
                  isLoading: _isLoading,
                  child: CardListItem(isLoading: _isLoading)),
              const SizedBox(height: 20),
              ShimmerLoading(
                  isLoading: _isLoading,
                  child: CardListItem(isLoading: _isLoading)),
            ],
          ),
        ),
      ),
    );
  }
}
