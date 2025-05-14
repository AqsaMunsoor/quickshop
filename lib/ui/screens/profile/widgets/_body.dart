part of '../profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: Space.p.screen,
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(title: 'Aqsa Munsoor', showBackButton: false),
            Space.y.t20,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  Space.x.t16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aqsa Munsoor', style: AppText.t16 + Colors.white),
                      Space.y.t04,
                      Text(
                        'aqsamansur00@gmail.com',
                        style: AppText.t12 + Colors.white70,
                      ),
                      Space.y.t02,
                      Text('07XXXXXXXX', style: AppText.t12 + Colors.white70),
                    ],
                  ),
                ],
              ),
            ),
            Space.y.t30,
            const _SettingsTile(
              icon: HugeIcons.strokeRoundedSettings01,
              title: 'aqsa munsoor',
            ),
            const _SettingsTile(
              icon: HugeIcons.strokeRoundedWallet01,
              title: 'ubl visa card',
            ),
            const _SettingsTile(
              icon: HugeIcons.strokeRoundedCustomerSupport,
              title: 'Support',
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SettingsTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 24),
          Space.x.t12,
          Text(title, style: AppText.t16),
        ],
      ),
    );
  }
}
