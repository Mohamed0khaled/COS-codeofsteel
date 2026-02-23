import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:coursesapp/features/courses/domain/entities/course_entity.dart';
import 'package:coursesapp/View/courses/video_page.dart';

/// Course detail page showing lessons from Firestore
class CourseDetailPage extends StatefulWidget {
  final CourseEntity course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final snapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.course.id.toString())
          .collection('lessons')
          .orderBy('id')
          .get();

      final loadedLessons = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': data['id'] ?? 0,
          'title': data['title'] ?? 'Untitled',
          'description': data['description'] ?? '',
          'videoUrl': data['videoUrl'] ?? '',
          'duration': data['duration'] ?? '0:00',
          'timestamps': data['timestamps'] ?? [],
          'hasQuiz': data['hasQuiz'] ?? false,
          'hasProblemSolving': data['hasProblemSolving'] ?? false,
          'isCompleted': data['isCompleted'] ?? false,
        };
      }).toList();

      setState(() {
        lessons = loadedLessons;
        isLoading = false;
      });

      print('✅ Loaded ${lessons.length} lessons for course ${widget.course.id}');
    } catch (e) {
      print('❌ Error loading lessons: $e');
      setState(() {
        errorMessage = 'Failed to load lessons: $e';
        isLoading = false;
      });
    }
  }

  void _openLesson(Map<String, dynamic> lesson, int index) {
    final videoUrl = lesson['videoUrl'] as String;
    if (videoUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video available for this lesson')),
      );
      return;
    }

    // Parse timestamps
    List<Map<String, dynamic>> timestamps = [];
    if (lesson['timestamps'] != null) {
      timestamps = List<Map<String, dynamic>>.from(lesson['timestamps']);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPage(
          title: lesson['title'],
          videoURL: videoUrl,
          timeStamps: timestamps,
          onNextPage: () {
            // Go to next lesson if available
            if (index < lessons.length - 1) {
              Navigator.pop(context);
              _openLesson(lessons[index + 1], index + 1);
            } else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🎉 Course completed!')),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Course Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.course.name,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  widget.course.cardImage.isNotEmpty
                      ? Image.network(
                          widget.course.cardImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.blue.shade700,
                            child: const Icon(Icons.school, size: 80, color: Colors.white54),
                          ),
                        )
                      : Container(
                          color: Colors.blue.shade700,
                          child: const Icon(Icons.school, size: 80, color: Colors.white54),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Course Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  if (widget.course.owned) ...[
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: widget.course.progress / 100,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation(Colors.green),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${widget.course.progress}%'),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Price / Owned badge
                  Row(
                    children: [
                      if (widget.course.owned)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '✓ Owned',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.course.price == 0 ? 'Free' : '\$${widget.course.price}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          widget.course.favorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.course.favorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          // TODO: Toggle favorite
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          widget.course.saved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        onPressed: () {
                          // TODO: Toggle saved
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Lessons header
                  Text(
                    'Lessons (${lessons.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Lessons List
          if (isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(errorMessage!, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadLessons,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (lessons.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text('No lessons available yet.\nCheck back soon!', textAlign: TextAlign.center),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final lesson = lessons[index];
                  return _LessonTile(
                    lessonNumber: lesson['id'],
                    title: lesson['title'],
                    duration: lesson['duration'],
                    hasQuiz: lesson['hasQuiz'],
                    hasProblemSolving: lesson['hasProblemSolving'],
                    isCompleted: lesson['isCompleted'],
                    isLocked: !widget.course.owned && widget.course.price > 0,
                    onTap: () => _openLesson(lesson, index),
                  );
                },
                childCount: lessons.length,
              ),
            ),
        ],
      ),

      // Start/Continue button
      bottomNavigationBar: widget.course.owned && lessons.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // Find first incomplete lesson or start from beginning
                    final nextLessonIndex = lessons.indexWhere((l) => !(l['isCompleted'] ?? false));
                    final startIndex = nextLessonIndex >= 0 ? nextLessonIndex : 0;
                    _openLesson(lessons[startIndex], startIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.course.progress > 0 ? 'Continue Learning' : 'Start Course',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

class _LessonTile extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final String duration;
  final bool hasQuiz;
  final bool hasProblemSolving;
  final bool isCompleted;
  final bool isLocked;
  final VoidCallback onTap;

  const _LessonTile({
    required this.lessonNumber,
    required this.title,
    required this.duration,
    required this.hasQuiz,
    required this.hasProblemSolving,
    required this.isCompleted,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isCompleted
            ? Colors.green
            : isLocked
                ? Colors.grey
                : Colors.blue,
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white)
            : isLocked
                ? const Icon(Icons.lock, color: Colors.white)
                : Text(
                    '$lessonNumber',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isLocked ? Colors.grey : null,
        ),
      ),
      subtitle: Row(
        children: [
          Text(duration),
          if (hasQuiz) ...[
            const SizedBox(width: 8),
            const Icon(Icons.quiz, size: 16, color: Colors.orange),
          ],
          if (hasProblemSolving) ...[
            const SizedBox(width: 8),
            const Icon(Icons.code, size: 16, color: Colors.purple),
          ],
        ],
      ),
      trailing: isLocked
          ? const Icon(Icons.lock_outline, color: Colors.grey)
          : const Icon(Icons.play_circle_outline, color: Colors.blue),
      onTap: isLocked
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase this course to unlock lessons')),
              );
            }
          : onTap,
    );
  }
}
