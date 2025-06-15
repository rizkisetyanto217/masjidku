import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // ⬅️ PENTING: pastikan import go_router
import 'package:masjidku/presentation/all/home/main/cubit/carousel/carousel_cubit.dart';
import 'package:masjidku/presentation/all/home/main/model/caraousel_model.dart';

class PosterCarouselDynamic extends StatefulWidget {
  const PosterCarouselDynamic({super.key});

  @override
  State<PosterCarouselDynamic> createState() => _PosterCarouselDynamicState();
}

class _PosterCarouselDynamicState extends State<PosterCarouselDynamic> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CarouselCubit>().fetchCarousels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        if (state is CarouselLoading) {
          return const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CarouselLoaded) {
          final List<CarouselModel> carousels = state.carousels;
          return Column(
            children: [
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: carousels.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final carousel = carousels[index];
                    final imageUrl = carousel.carouselImageUrl;

                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/carousel-detail',
                          extra: carousels[index],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Container(color: Colors.grey[300]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  carousels.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is CarouselError) {
          return SizedBox(
            height: 160,
            child: Center(child: Text(state.message)),
          );
        } else {
          return const SizedBox(height: 160);
        }
      },
    );
  }
}
