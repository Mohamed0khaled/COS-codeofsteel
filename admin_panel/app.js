// ============================================
// FIREBASE CONFIGURATION
// ============================================
const firebaseConfig = {
    apiKey: "AIzaSyBqE-Xsmxv-IbNrJLdqoZFcuGDrUzBck_g",
    authDomain: "code-of-steel.firebaseapp.com",
    projectId: "code-of-steel",
    storageBucket: "code-of-steel.firebasestorage.app",
    messagingSenderId: "937709820605",
    appId: "1:937709820605:web:74caaf684d63dadf7e35d4",
    measurementId: "G-5DSPJYX2C4"
};

// ============================================
// INITIALIZE FIREBASE
// ============================================
firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();
const auth = firebase.auth();

// ============================================
// AUTHENTICATION
// ============================================
const authSection = document.getElementById('auth-section');
const mainContent = document.getElementById('main-content');
const userEmailSpan = document.getElementById('user-email');
const loginForm = document.getElementById('login-form');
const authError = document.getElementById('auth-error');

// Check auth state on page load
auth.onAuthStateChanged((user) => {
    if (user) {
        // User is signed in
        authSection.style.display = 'none';
        mainContent.style.display = 'block';
        userEmailSpan.textContent = `👤 ${user.email}`;
        loadCourses();
        loadCourseDropdown();
    } else {
        // User is signed out
        authSection.style.display = 'block';
        mainContent.style.display = 'none';
    }
});

// Login form handler
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    
    try {
        await auth.signInWithEmailAndPassword(email, password);
        authError.textContent = '';
    } catch (error) {
        authError.textContent = `❌ ${error.message}`;
    }
});

// Logout function
function logout() {
    auth.signOut();
}

// ============================================
// TAB NAVIGATION
// ============================================
function showTab(tabId) {
    // Hide all tab contents
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.remove('active');
    });
    
    // Remove active class from all tabs
    document.querySelectorAll('.tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Show selected tab content
    document.getElementById(tabId).classList.add('active');
    
    // Add active class to clicked tab
    event.target.classList.add('active');
    
    // Refresh data when switching tabs
    if (tabId === 'view-courses') {
        loadCourses();
    } else if (tabId === 'add-lesson') {
        loadCourseDropdown();
    }
}

// ============================================
// COURSE MANAGEMENT
// ============================================
const courseForm = document.getElementById('course-form');
const courseMessage = document.getElementById('course-message');

// Add course form handler
courseForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const courseData = {
        id: parseInt(document.getElementById('course-id').value),
        name: document.getElementById('course-name').value,
        description: document.getElementById('course-description').value || '',
        card_image: document.getElementById('course-image').value,
        category: document.getElementById('course-category').value,
        difficulty: document.getElementById('course-difficulty').value,
        price: parseInt(document.getElementById('course-price').value),
        // Default values for user-specific fields
        favorite: false,
        saved: false,
        finished: false,
        progress: 0,
        owned: document.getElementById('course-price').value === '0',
        // Metadata
        createdAt: firebase.firestore.FieldValue.serverTimestamp(),
        updatedAt: firebase.firestore.FieldValue.serverTimestamp(),
        lessonCount: 0
    };
    
    try {
        // Save to 'courses' collection (global courses catalog)
        await db.collection('courses').doc(courseData.id.toString()).set(courseData);
        
        showMessage(courseMessage, '✅ Course added successfully!', 'success');
        courseForm.reset();
        loadCourseDropdown();
    } catch (error) {
        showMessage(courseMessage, `❌ Error: ${error.message}`, 'error');
    }
});

// Load all courses
async function loadCourses() {
    const coursesList = document.getElementById('courses-list');
    coursesList.innerHTML = '<p class="loading">Loading courses...</p>';
    
    try {
        const snapshot = await db.collection('courses').orderBy('id').get();
        
        if (snapshot.empty) {
            coursesList.innerHTML = '<p class="loading">No courses found. Add your first course!</p>';
            return;
        }
        
        coursesList.innerHTML = '';
        snapshot.forEach(doc => {
            const course = doc.data();
            coursesList.innerHTML += createCourseCard(course, doc.id);
        });
    } catch (error) {
        coursesList.innerHTML = `<p class="error">Error loading courses: ${error.message}</p>`;
    }
}

// Create course card HTML
function createCourseCard(course, docId) {
    const difficultyClass = `badge-${course.difficulty || 'beginner'}`;
    const priceText = course.price === 0 ? 'FREE' : `$${course.price}`;
    
    return `
        <div class="course-card">
            <img src="${course.card_image}" alt="${course.name}" onerror="this.src='https://via.placeholder.com/300x180?text=No+Image'">
            <div class="course-card-content">
                <h3>${course.name}</h3>
                <p>${course.description || 'No description'}</p>
                <div class="meta">
                    <span class="badge ${difficultyClass}">${course.difficulty || 'Beginner'}</span>
                    <span class="price">${priceText}</span>
                </div>
                <div class="meta" style="margin-top: 8px;">
                    <span>ID: ${course.id}</span>
                    <span>${course.lessonCount || 0} lessons</span>
                </div>
                <div class="actions">
                    <button class="btn btn-secondary btn-small" onclick="viewLessons('${docId}')">📚 Lessons</button>
                    <button class="btn btn-danger btn-small" onclick="deleteCourse('${docId}')">🗑️ Delete</button>
                </div>
            </div>
        </div>
    `;
}

// Delete course
async function deleteCourse(docId) {
    if (!confirm('Are you sure you want to delete this course? This will also delete all lessons.')) {
        return;
    }
    
    try {
        // Delete all lessons first
        const lessonsSnapshot = await db.collection('courses').doc(docId).collection('lessons').get();
        const batch = db.batch();
        lessonsSnapshot.docs.forEach(doc => {
            batch.delete(doc.ref);
        });
        await batch.commit();
        
        // Delete the course
        await db.collection('courses').doc(docId).delete();
        
        alert('Course deleted successfully!');
        loadCourses();
        loadCourseDropdown();
    } catch (error) {
        alert(`Error deleting course: ${error.message}`);
    }
}

// View lessons (shows alert for now - can be expanded)
async function viewLessons(courseId) {
    try {
        const lessonsSnapshot = await db.collection('courses').doc(courseId).collection('lessons').orderBy('id').get();
        
        if (lessonsSnapshot.empty) {
            alert('No lessons in this course yet. Add some lessons in the "Add Lesson" tab!');
            return;
        }
        
        let lessonList = 'Lessons:\n\n';
        lessonsSnapshot.forEach(doc => {
            const lesson = doc.data();
            lessonList += `${lesson.id}. ${lesson.title} (${lesson.duration})\n`;
        });
        
        alert(lessonList);
    } catch (error) {
        alert(`Error loading lessons: ${error.message}`);
    }
}

// ============================================
// LESSON MANAGEMENT
// ============================================
const lessonForm = document.getElementById('lesson-form');
const lessonMessage = document.getElementById('lesson-message');

// Load course dropdown for lesson form
async function loadCourseDropdown() {
    const dropdown = document.getElementById('lesson-course-id');
    dropdown.innerHTML = '<option value="">Loading courses...</option>';
    
    try {
        const snapshot = await db.collection('courses').orderBy('id').get();
        
        dropdown.innerHTML = '<option value="">Select a course...</option>';
        snapshot.forEach(doc => {
            const course = doc.data();
            dropdown.innerHTML += `<option value="${doc.id}">${course.id}. ${course.name}</option>`;
        });
    } catch (error) {
        dropdown.innerHTML = '<option value="">Error loading courses</option>';
    }
}

// Add lesson form handler
lessonForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const courseId = document.getElementById('lesson-course-id').value;
    if (!courseId) {
        showMessage(lessonMessage, '❌ Please select a course', 'error');
        return;
    }
    
    // Parse timestamps if provided
    let timestamps = [];
    const timestampsInput = document.getElementById('lesson-timestamps').value.trim();
    if (timestampsInput) {
        try {
            timestamps = JSON.parse(timestampsInput);
        } catch (error) {
            showMessage(lessonMessage, '❌ Invalid timestamps format. Use JSON array format.', 'error');
            return;
        }
    }
    
    const lessonData = {
        id: parseInt(document.getElementById('lesson-id').value),
        title: document.getElementById('lesson-title').value,
        description: document.getElementById('lesson-description').value || '',
        videoUrl: document.getElementById('lesson-video').value,
        duration: document.getElementById('lesson-duration').value,
        timestamps: timestamps,
        hasQuiz: document.getElementById('lesson-has-quiz').checked,
        hasProblemSolving: document.getElementById('lesson-has-problems').checked,
        isCompleted: false,
        createdAt: firebase.firestore.FieldValue.serverTimestamp()
    };
    
    try {
        // Add lesson to course's lessons subcollection
        await db.collection('courses').doc(courseId).collection('lessons')
            .doc(lessonData.id.toString()).set(lessonData);
        
        // Update lesson count on course
        const courseRef = db.collection('courses').doc(courseId);
        const lessonsCount = (await courseRef.collection('lessons').get()).size;
        await courseRef.update({ 
            lessonCount: lessonsCount,
            updatedAt: firebase.firestore.FieldValue.serverTimestamp()
        });
        
        showMessage(lessonMessage, '✅ Lesson added successfully!', 'success');
        
        // Reset form but keep course selected
        const selectedCourse = document.getElementById('lesson-course-id').value;
        lessonForm.reset();
        document.getElementById('lesson-course-id').value = selectedCourse;
        
    } catch (error) {
        showMessage(lessonMessage, `❌ Error: ${error.message}`, 'error');
    }
});

// ============================================
// UTILITY FUNCTIONS
// ============================================
function showMessage(element, text, type) {
    element.textContent = text;
    element.className = `message ${type}`;
    
    // Auto-hide after 5 seconds
    setTimeout(() => {
        element.textContent = '';
        element.className = 'message';
    }, 5000);
}

// ============================================
// INITIALIZE
// ============================================
console.log('🚀 Course Admin Panel loaded');
console.log('📌 Make sure to update firebaseConfig with your web app credentials!');
