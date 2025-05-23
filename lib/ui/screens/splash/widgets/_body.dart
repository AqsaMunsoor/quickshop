part of '../splash.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      AppRoutes.home.pushReplace(context);
    });

    final screenHeight = MediaQuery.of(context).size.height;

    return Screen(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg/splash.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: screenHeight * 0.15),

                  Text(
                    'My Store',
                    textAlign: TextAlign.center,
                    style: AppText.t50.copyWith(color: AppColors.white),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    child: Column(
                      children: [
                        Text(
                          'Välkommen',
                          textAlign: TextAlign.center,
                          style: AppText.t20.bold.whiteColor,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Hos oss kan du boka tid hos nästan alla Sveriges salonger och mottagningar. Boka frisör, massage, skönhetsbehandlingar, friskvård och mycket mer.',
                          textAlign: TextAlign.center,
                          style: AppText.t18.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
