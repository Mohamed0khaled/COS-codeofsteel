# Course Admin Panel

A simple web-based admin panel to manage courses and lessons in Firebase.

## 📁 Files

- `index.html` - Main HTML page
- `styles.css` - Styling
- `app.js` - Firebase JavaScript code

---

## 🚀 Setup Instructions

### Step 1: Configure Firebase

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **code-of-steel**
3. Click the gear icon ⚙️ → **Project settings**
4. Scroll down to **Your apps** section
5. If you don't have a web app, click **Add app** → **Web** 🌐
6. Copy the `firebaseConfig` values

### Step 2: Update app.js

Open `app.js` and replace the config at the top:

```javascript
const firebaseConfig = {
    apiKey: "YOUR_ACTUAL_API_KEY",           // ← Replace this
    authDomain: "code-of-steel.firebaseapp.com",
    projectId: "code-of-steel",
    storageBucket: "code-of-steel.appspot.com",
    messagingSenderId: "937709820605",
    appId: "YOUR_ACTUAL_APP_ID"              // ← Replace this
};
```

### Step 3: Create Admin Account

You need a Firebase Auth account to login:

1. Firebase Console → **Authentication** → **Users** tab
2. Click **Add user**
3. Enter email and password
4. This will be your admin login

### Step 4: Enable Firestore

1. Firebase Console → **Firestore Database**
2. Click **Create database**
3. Start in **test mode** (for development)
4. Choose a location

---

## ▶️ How to Run

### Option A: Simple (Double-click)
Just double-click `index.html` to open in browser.

⚠️ If you get CORS errors, use Option B instead.

### Option B: Local Server (Recommended)

Using Python:
```bash
cd admin_panel
python3 -m http.server 8000
```
Then open: http://localhost:8000

Using Node.js:
```bash
npx serve admin_panel
```

---

## 📝 How to Use

### 1. Login
- Enter your Firebase admin email/password
- Click Login

### 2. Add a Course
- Go to **Add Course** tab
- Fill in:
  - **Course ID**: Unique number (1, 2, 3...)
  - **Course Name**: Title shown to users
  - **Description**: Optional course description
  - **Card Image URL**: Image URL for course card
  - **Category**: programming, design, etc.
  - **Difficulty**: Beginner, Intermediate, Advanced
  - **Price**: 0 for free courses
- Click **Add Course**

### 3. Add Lessons
- Go to **Add Lesson** tab
- Select a course
- Fill in:
  - **Lesson ID**: Lesson number (1, 2, 3...)
  - **Lesson Title**: Title of the lesson
  - **Description**: What the lesson covers
  - **Video URL**: YouTube or video URL
  - **Duration**: e.g., "12:30"
  - **Timestamps**: Optional JSON array
  - **Has Quiz**: Check if lesson has quiz
  - **Has Problems**: Check if lesson has coding problems
- Click **Add Lesson**

### 4. View Courses
- Go to **View Courses** tab
- See all courses in a grid
- Click **Lessons** to see course lessons
- Click **Delete** to remove a course

---

## 📊 Data Structure

### Firestore Collections

```
courses/
├── 1/                          (document ID = course ID)
│   ├── id: 1
│   ├── name: "Flutter Basics"
│   ├── description: "..."
│   ├── card_image: "https://..."
│   ├── category: "programming"
│   ├── difficulty: "beginner"
│   ├── price: 0
│   ├── lessonCount: 3
│   ├── favorite: false          (user-specific, updated by app)
│   ├── saved: false
│   ├── finished: false
│   ├── progress: 0
│   ├── owned: true
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
│
│   └── lessons/                 (subcollection)
│       ├── 1/
│       │   ├── id: 1
│       │   ├── title: "Introduction"
│       │   ├── videoUrl: "https://..."
│       │   ├── duration: "5:30"
│       │   ├── hasQuiz: true
│       │   └── hasProblemSolving: false
│       └── 2/
│           └── ...
```

---

## 🔧 Timestamps Format

Example timestamp JSON:
```json
[
    {"time": "0:00", "label": "Introduction"},
    {"time": "2:30", "label": "Setup"},
    {"time": "5:00", "label": "First Widget"}
]
```

---

## ❓ Troubleshooting

### "Firebase is not defined" error
- Make sure you're connected to the internet
- The Firebase SDK is loaded from CDN

### "Permission denied" error
- Check Firestore rules allow write access
- For testing, use these rules:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Login fails
- Make sure the user exists in Firebase Auth
- Check email/password are correct
- Check browser console for specific error

### Images not showing
- Use full HTTPS image URLs
- Make sure the image URL is accessible

---

## 💡 Tips

1. **Course IDs** should be unique numbers (1, 2, 3...)
2. **Image URLs** - You can use Firebase Storage or any image hosting
3. **Test in browser console** - Check for errors (F12 → Console)
4. **Free courses** - Set price to 0, they will automatically be "owned"

---

Made for Code of Steel Course App 🎓
