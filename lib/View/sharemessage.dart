import 'dart:ui' as ui;

class ShareMessages {
  static bool isArabic() {
    final locale = ui.window.locale;
    return locale.languageCode.toLowerCase() == 'ar';
  }

  static String get message => isArabic() ? _arabicMessage : _englishMessage;

  static const String _englishMessage = '''
🚀 **Welcome to Code of Steel!** 🚀
Unlock your potential with the ultimate learning platform designed for future tech leaders like you. Dive into expertly crafted courses, practical projects, and exclusive content that will sharpen your programming skills and transform your career.

✨ **Why Code of Steel?**

* High-quality, easy-to-follow courses
* Hands-on coding challenges and projects
* Learn from expert instructors with real-world experience
* Stay updated with the latest tech trends and tools

🔥 **Subscribe Now to Our Course: "Master Programming from Scratch"** 🔥
Whether you’re a beginner or looking to deepen your knowledge, this course is your key to mastering the fundamentals and beyond. Get ready for step-by-step lessons, real coding examples, and personalized support.

👉 Download **Code of Steel** today and start your journey toward becoming a programming expert! Don’t miss out – subscribe now and code your future with steel!
''';

  static const String _arabicMessage = '''
🚀 **مرحبًا بك في Code of Steel!** 🚀
افتح آفاقك مع أفضل منصة تعليمية مخصصة لرواد التقنية في المستقبل مثلك. استمتع بدورات احترافية، مشاريع تطبيقية، ومحتوى حصري يُطوّر مهاراتك البرمجية ويغير مسار حياتك المهنية.

✨ **لماذا تختار Code of Steel؟**

* دورات عالية الجودة وسهلة المتابعة
* تحديات ومشاريع عملية
* تعلّم من خبراء لديهم خبرة فعلية في المجال
* تابع أحدث التقنيات والأدوات باستمرار

🔥 **اشترك الآن في دورتنا: "إتقان البرمجة من الصفر"** 🔥
سواء كنت مبتدئًا أو تريد تعميق معرفتك، هذه الدورة هي مفتاحك لإتقان الأساسيات وأكثر. دروس خطوة بخطوة، أمثلة برمجية واقعية، ودعم شخصي في انتظارك.

👉 حمّل تطبيق **Code of Steel** الآن وابدأ رحلتك لتصبح محترف برمجة! لا تفوّت الفرصة – اشترك الآن واصنع مستقبلك بقوة الحديد!
''';
}
