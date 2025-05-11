<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Tracker Pro</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.2/Sortable.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- Base & Theme --- */
        :root {
            --bg-primary: #f8fafc; /* Tailwind slate-50 */
            --bg-secondary: #ffffff; /* White */
            --bg-accent: #eef2ff; /* Tailwind indigo-50 */
            --text-primary: #1e293b; /* Tailwind slate-800 */
            --text-secondary: #475569; /* Tailwind slate-600 */
            --text-muted: #94a3b8; /* Tailwind slate-400 */
            --border-primary: #e2e8f0; /* Tailwind slate-200 */
            --accent-color: #6366f1; /* Tailwind indigo-500 */
            --accent-color-hover: #4f46e5; /* Tailwind indigo-600 */
            --danger-color: #ef4444; /* Tailwind red-500 */
            --danger-color-hover: #dc2626; /* Tailwind red-600 */
            --success-color: #22c55e; /* Tailwind green-500 */
            --warning-color: #f59e0b; /* Tailwind amber-500 */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: var(--bg-primary);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            background: #cbd5e1; /* Tailwind slate-300 */
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #94a3b8; /* Tailwind slate-400 */
        }

        /* --- Layout & Cards --- */
        .main-container {
            max-width: 1400px; /* Increased max-width for wider screens */
        }

        .notion-card {
            background-color: var(--bg-secondary);
            border-radius: 0.75rem; /* rounded-xl */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05); /* Softer shadow */
            padding: 1.5rem; /* p-6 */
            margin-bottom: 2rem; /* mb-8, increased spacing */
            transition: box-shadow 0.2s ease-in-out;
        }
        .notion-card:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.07), 0 4px 6px -4px rgba(0, 0, 0, 0.07);
        }

        .section-title {
            font-size: 1.25rem; /* text-xl */
            font-weight: 600; /* semibold */
            margin-bottom: 1.25rem; /* mb-5 */
            color: var(--text-primary);
            display: flex;
            align-items: center;
        }
        .section-title i {
            margin-right: 0.75rem; /* mr-3 */
            color: var(--accent-color); /* Use accent for section icons */
        }

        /* --- Forms & Buttons --- */
        .notion-input {
            border: 1px solid var(--border-primary);
            border-radius: 0.5rem; /* rounded-lg */
            padding: 0.75rem 1rem; /* py-3 px-4 */
            width: 100%;
            transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            background-color: var(--bg-primary); /* Slightly different bg for inputs */
            color: var(--text-primary);
        }
        .notion-input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2); /* Indigo focus ring */
        }
        .notion-input::placeholder {
            color: var(--text-muted);
        }

        .notion-button {
            background-color: var(--accent-color);
            color: white;
            font-weight: 500; /* medium */
            padding: 0.625rem 1.25rem; /* py-2.5 px-5 */
            border-radius: 0.5rem; /* rounded-lg */
            transition: background-color 0.2s ease-in-out, transform 0.1s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem; /* space-x-2 */
        }
        .notion-button:hover {
            background-color: var(--accent-color-hover);
            transform: translateY(-1px);
        }
        .notion-button:active {
            transform: translateY(0px);
        }
        .notion-button-secondary {
            background-color: var(--bg-accent);
            color: var(--accent-color);
            font-weight: 500;
        }
        .notion-button-secondary:hover {
            background-color: #dbeafe; /* Tailwind blue-100 for indigo accent */
        }
        .notion-button-danger {
            background-color: var(--danger-color);
            color: white;
        }
        .notion-button-danger:hover {
            background-color: var(--danger-color-hover);
        }

        .icon-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0.375rem; /* p-1.5 */
            color: var(--text-secondary);
            border-radius: 0.375rem; /* rounded-md */
            transition: color 0.2s ease-in-out, background-color 0.2s ease-in-out;
        }
        .icon-button:hover {
            color: var(--accent-color);
            background-color: var(--bg-accent);
        }
        .icon-button.danger:hover {
            color: var(--danger-color);
            background-color: #fee2e2; /* Tailwind red-100 */
        }
        .icon-button i {
            font-size: 0.875rem; /* text-sm */
        }

        /* --- Task & Exam Items --- */
        .task-item, .exam-item {
            padding: 1rem; /* p-4 */
            border: 1px solid var(--border-primary);
            border-radius: 0.5rem; /* rounded-lg */
            background-color: var(--bg-secondary);
            transition: box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out;
            margin-bottom: 0.75rem; /* mb-3 */
        }
        .task-item:hover, .exam-item:hover {
            border-color: #c7d2fe; /* Tailwind indigo-200 */
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
        }
        .task-item.completed {
            background-color: #f0fdf4; /* Tailwind green-50 */
            border-left: 4px solid var(--success-color);
        }
        .task-item.completed .task-description,
        .task-item.completed .task-subject,
        .task-item.completed .task-topic {
            text-decoration: line-through;
            color: var(--text-muted);
        }
        .exam-item.is-past {
            background-color: #f1f5f9; /* Tailwind slate-100 */
            opacity: 0.7;
            border-left: 4px solid var(--text-muted);
        }
        .task-subject { font-weight: 600; color: var(--text-primary); margin-bottom: 0.25rem; }
        .task-description { font-size: 0.875rem; color: var(--text-secondary); }
        .task-topic { font-size: 0.75rem; color: var(--text-muted); margin-top: 0.25rem; }
        .task-notes-display {
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px dashed var(--border-primary);
            white-space: pre-wrap; /* Preserve line breaks in notes */
        }
        .task-notes-display strong { color: var(--text-primary); }

        .cursor-grab { cursor: grab; }
        .sortable-ghost {
            opacity: 0.5;
            background: var(--bg-accent);
            border: 1px dashed var(--accent-color);
        }

        /* --- Dashboard Enhancements --- */
        #dashboard-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); /* Responsive grid for stat cards */
            gap: 1rem; /* gap-4 */
        }
        .stat-card {
            background-color: var(--bg-accent);
            border-radius: 0.75rem; /* rounded-xl */
            padding: 1.25rem; /* p-5 */
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            border: 1px solid #d1d5db; /* Tailwind gray-300, slightly darker for accent bg */
        }
        .stat-card-icon {
            font-size: 1.75rem; /* text-3xl */
            margin-bottom: 0.75rem; /* mb-3 */
        }
        .stat-card-value {
            font-size: 2rem; /* text-4xl */
            font-weight: 700; /* bold */
            color: var(--accent-color);
            line-height: 1;
        }
        .stat-card-label {
            font-size: 0.875rem; /* text-sm */
            color: var(--text-secondary);
            margin-top: 0.25rem; /* mt-1 */
        }
        .stat-card-extra {
            font-size: 0.75rem; /* text-xs */
            color: var(--text-muted);
            margin-top: 0.5rem; /* mt-2 */
        }
        #db-today-tasks-by-subject-card { /* Specific styling for subject breakdown */
            grid-column: span 1 / span 1; /* Default span */
        }
        @media (min-width: 640px) { /* sm breakpoint */
            #db-today-tasks-by-subject-card {
                grid-column: span 2 / span 2; /* Make subject breakdown wider on larger screens */
            }
        }
        #db-today-tasks-by-subject {
            list-style: none;
            padding-left: 0;
            text-align: left;
            width: 100%;
        }
        #db-today-tasks-by-subject li {
            padding: 0.25rem 0;
            border-bottom: 1px solid #e5e7eb; /* Tailwind gray-200 */
        }
        #db-today-tasks-by-subject li:last-child {
            border-bottom: none;
        }


        /* --- Modals --- */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(30, 41, 59, 0.6); /* Tailwind slate-800 with opacity */
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem; /* Padding for smaller screens */
        }
        .modal-content {
            background-color: var(--bg-secondary);
            margin: auto;
            padding: 2rem;
            border-radius: 0.75rem; /* rounded-xl */
            width: 100%;
            max-width: 500px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1), 0 8px 10px -6px rgba(0,0,0,0.1);
        }
        .modal-content h3 {
            font-size: 1.5rem; /* text-2xl */
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
        }
        .modal-content label {
            font-weight: 500;
            color: var(--text-secondary);
        }

        /* --- Header --- */
        .app-header {
            background-color: var(--bg-secondary);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }
        .app-header h1 {
            color: var(--accent-color);
        }
        .app-header h1 i {
            color: var(--accent-color);
        }

        /* Timer specific styling */
        .timer-controls {
            margin-top: 0.75rem; /* mt-3 */
            padding-top: 0.75rem; /* pt-3 */
            border-top: 1px solid var(--border-primary);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .timer-controls .font-mono {
            font-size: 0.875rem; /* text-sm */
            color: var(--accent-color);
            font-weight: 500;
        }
        .timer-controls .notion-button {
            padding: 0.375rem 0.75rem; /* py-1.5 px-3 */
            font-size: 0.75rem; /* text-xs */
        }
        .timer-controls .notion-button i {
            margin-right: 0.25rem; /* mr-1 */
        }

        /* Checkbox styling */
        .toggle-today-task-complete {
            appearance: none;
            background-color: transparent;
            margin: 0;
            font: inherit;
            color: currentColor;
            width: 1.15em;
            height: 1.15em;
            border: 0.15em solid var(--border-primary);
            border-radius: 0.25em;
            transform: translateY(-0.075em);
            display: grid;
            place-content: center;
            cursor: pointer;
        }
        .toggle-today-task-complete::before {
            content: "";
            width: 0.65em;
            height: 0.65em;
            transform: scale(0);
            transition: 120ms transform ease-in-out;
            box-shadow: inset 1em 1em var(--accent-color);
            transform-origin: bottom left;
            clip-path: polygon(14% 44%, 0 65%, 50% 100%, 100% 16%, 80% 0%, 43% 62%);
        }
        .toggle-today-task-complete:checked::before {
            transform: scale(1);
        }
        .toggle-today-task-complete:focus {
            outline: max(2px, 0.15em) solid var(--accent-color);
            outline-offset: max(2px, 0.15em);
        }
        .toggle-today-task-complete:disabled {
            color: var(--text-muted);
            cursor: not-allowed;
        }
        .exam-countdown-text {
            font-weight: 500;
        }
        .exam-countdown-text.is-past {
            color: var(--text-muted);
            font-style: italic;
        }
        .exam-countdown-text.is-upcoming {
            color: var(--warning-color);
        }

    </style>
</head>
<body class="text-slate-800">

    <header class="app-header">
        <div class="main-container mx-auto px-4 sm:px-6 lg:px-8 py-4">
            <h1 class="text-3xl font-bold flex items-center">
                <i class="fas fa-book-reader mr-3 text-3xl"></i>Study Tracker Pro
            </h1>
        </div>
    </header>

    <main class="main-container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-x-8"> <div class="lg:col-span-1 space-y-8"> <div class="notion-card">
                    <h2 class="section-title"><i class="fas fa-chart-pie text-purple-500"></i>Dashboard</h2>
                    <div id="dashboard-content">
                        </div>
                </div>

                 <div class="notion-card">
                    <h2 class="section-title"><i class="fas fa-calendar-check text-red-500"></i>Exam Deadlines</h2>
                    <button id="addExamBtn" class="notion-button text-sm mb-6 w-full"><i class="fas fa-plus"></i>Add Exam</button>
                    <div id="examList" class="space-y-3 max-h-[28rem] overflow-y-auto pr-2"> </div>
                </div>
            </div>

            <div class="lg:col-span-2 space-y-8"> <div class="notion-card">
                    <h2 class="section-title"><i class="fas fa-star text-yellow-500"></i>Today's Focus</h2>
                    <button id="addTodayTaskBtn" class="notion-button text-sm mb-6 w-full"><i class="fas fa-plus"></i>Add Task for Today</button>
                    <div id="todayTaskList" class="space-y-3 min-h-[150px]"> </div>
                </div>

                <div class="notion-card">
                    <h2 class="section-title"><i class="fas fa-clipboard-list text-green-500"></i>Overall Study Plan</h2>
                    <button id="addOverallTaskBtn" class="notion-button text-sm mb-6 w-full"><i class="fas fa-plus"></i>Add Overall Task</button>
                    <div id="overallTaskList" class="space-y-3 min-h-[150px]"> </div>
                </div>
            </div>
        </div>
    </main>

    <div id="examModal" class="modal">
        <div class="modal-content space-y-6"> <h3 id="examModalTitle">Add Exam</h3>
            <input type="hidden" id="examId">
            <div>
                <label for="examName" class="block text-sm font-medium mb-1">Exam Name</label>
                <input type="text" id="examName" class="notion-input mt-1" placeholder="e.g., Midterm Algebra">
            </div>
            <div>
                <label for="examDate" class="block text-sm font-medium mb-1">Exam Date</label>
                <input type="date" id="examDate" class="notion-input mt-1">
            </div>
            <div class="flex justify-end space-x-3 pt-2"> <button id="cancelExamModal" class="notion-button notion-button-secondary">Cancel</button>
                <button id="saveExamBtn" class="notion-button">Save Exam</button>
            </div>
        </div>
    </div>

    <div id="taskModal" class="modal">
        <div class="modal-content space-y-6"> <h3 id="taskModalTitle">Add Task</h3>
            <input type="hidden" id="taskId">
            <input type="hidden" id="taskListType">
            <div>
                <label for="taskSubject" class="block text-sm font-medium mb-1">Subject</label>
                <input type="text" id="taskSubject" class="notion-input mt-1" placeholder="e.g., Mathematics">
            </div>
            <div>
                <label for="taskDescription" class="block text-sm font-medium mb-1">Task Description</label>
                <input type="text" id="taskDescription" class="notion-input mt-1" placeholder="e.g., Review Chapter 3">
            </div>
            <div>
                <label for="taskTopic" class="block text-sm font-medium mb-1">Topic Covered/Tested</label>
                <input type="text" id="taskTopic" class="notion-input mt-1" placeholder="e.g., Polynomials">
            </div>
            <div>
                <label for="taskNotes" class="block text-sm font-medium mb-1">Notes</label>
                <textarea id="taskNotes" rows="4" class="notion-input mt-1" placeholder="e.g., Focus on exercises 3.1-3.5"></textarea>
            </div>
            <div class="flex justify-end space-x-3 pt-2"> <button id="cancelTaskModal" class="notion-button notion-button-secondary">Cancel</button>
                <button id="saveTaskBtn" class="notion-button">Save Task</button>
            </div>
        </div>
    </div>

    <div id="confirmationModal" class="modal">
        <div class="modal-content space-y-6"> <h3 id="confirmationModalTitle">Confirm Action</h3>
            <p id="confirmationModalMessage" class="text-slate-600">Are you sure?</p>
            <div class="flex justify-end space-x-3 pt-2"> <button id="cancelConfirmation" class="notion-button notion-button-secondary">Cancel</button>
                <button id="confirmAction" class="notion-button notion-button-danger">Confirm</button>
            </div>
        </div>
    </div>


<script>
$(document).ready(function() {
    // --- Globals & Configuration (Identical to previous version) ---
    let exams = [];
    let overallTasks = [];
    let todayTasks = [];
    let examCountdownIntervals = {};
    let taskTimerIntervals = {};
    let currentEditingExamId = null;
    let currentEditingTaskId = null;
    let currentEditingTaskListType = null;
    let confirmationCallback = null;

    const LS_EXAMS_KEY = 'studyTrackerExams_v2_enhancedUI_commentsFixed'; // Updated key
    const LS_OVERALL_TASKS_KEY = 'studyTrackerOverallTasks_v2_enhancedUI_commentsFixed'; // Updated key
    const LS_TODAY_TASKS_KEY = 'studyTrackerTodayTasks_v2_enhancedUI_commentsFixed'; // Updated key

    // --- Utility Functions (Identical) ---
    function generateId() {
        return Date.now().toString(36) + Math.random().toString(36).substr(2, 5);
    }

    function formatTime(ms) {
        if (ms === undefined || ms === null || ms < 0) ms = 0;
        const totalSeconds = Math.floor(ms / 1000);
        const hours = Math.floor(totalSeconds / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);
        const seconds = totalSeconds % 60;
        return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
    }

    // --- LocalStorage Functions (Identical) ---
    function saveData() {
        localStorage.setItem(LS_EXAMS_KEY, JSON.stringify(exams));
        localStorage.setItem(LS_OVERALL_TASKS_KEY, JSON.stringify(overallTasks));
        localStorage.setItem(LS_TODAY_TASKS_KEY, JSON.stringify(todayTasks));
    }

    function loadData() {
        exams = JSON.parse(localStorage.getItem(LS_EXAMS_KEY)) || [];
        overallTasks = JSON.parse(localStorage.getItem(LS_OVERALL_TASKS_KEY)) || [];
        todayTasks = JSON.parse(localStorage.getItem(LS_TODAY_TASKS_KEY)) || [];
        todayTasks.forEach(task => {
            if (task.isTracking) {
                if (task.startedAt) {
                    const interruptionTime = Date.now();
                    task.totalElapsedTime = (task.totalElapsedTime || 0) + (interruptionTime - task.startedAt);
                    task.isTracking = false;
                    task.startedAt = null;
                }
            }
            task.totalElapsedTime = task.totalElapsedTime || 0;
        });
    }

    // --- Modal Handling (Identical) ---
    function openModal(modalId) { $(`#${modalId}`).css('display', 'flex'); }
    function closeModal(modalId) { $(`#${modalId}`).hide(); }

    $('#cancelExamModal').click(() => closeModal('examModal'));
    $('#cancelTaskModal').click(() => closeModal('taskModal'));
    $('#cancelConfirmation').click(() => closeModal('confirmationModal'));
    $('#confirmAction').click(() => {
        if (confirmationCallback) confirmationCallback();
        closeModal('confirmationModal');
        confirmationCallback = null;
    });

    function showConfirmation(message, callback) {
        $('#confirmationModalMessage').text(message);
        confirmationCallback = callback;
        openModal('confirmationModal');
    }

    // --- Rendering Functions (Updated for new styles/structure) ---
    function renderExams() {
        const $examList = $('#examList').empty();
        if (exams.length === 0) {
            $examList.html('<p class="text-sm text-slate-500 px-1">No exams scheduled yet. Add one!</p>');
        }
        const sortedExams = [...exams].sort((a, b) => new Date(a.date) - new Date(b.date));

        sortedExams.forEach(exam => {
            const examDate = moment(exam.date);
            const isPast = examDate.isBefore(moment(), 'day');
            const $examItem = $(`
                <div class="exam-item ${isPast ? 'is-past' : ''}" data-id="${exam.id}">
                    <div class="flex justify-between items-center">
                        <div>
                            <h4 class="font-semibold text-slate-700">${exam.name}</h4>
                            <p class="text-xs text-slate-500">${examDate.format('dddd, MMMM D, YYYY')}</p>
                        </div>
                        <div class="flex items-center space-x-1">
                             <button class="edit-exam icon-button" title="Edit Exam"><i class="fas fa-edit"></i></button>
                             <button class="delete-exam icon-button danger" title="Delete Exam"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                    <div id="countdown-${exam.id}" class="text-sm mt-2 exam-countdown-text ${isPast ? 'is-past' : 'is-upcoming'}"></div>
                </div>
            `);
            $examList.append($examItem);
            updateExamCountdown(exam.id);
        });
        updateDashboard();
    }

    function renderOverallTasks() {
        const $taskList = $('#overallTaskList').empty();
        if (overallTasks.length === 0) {
            $taskList.html('<p class="text-sm text-slate-500 px-1">Your overall study plan is empty. Add some tasks!</p>');
        }
        overallTasks.forEach(task => {
            const $taskItem = $(`
                <div class="task-item cursor-grab" data-id="${task.id}">
                    <div class="flex justify-between items-start">
                        <div class="flex-grow mr-3">
                            <h5 class="task-subject">${task.subject || 'General Task'}</h5>
                            <p class="task-description">${task.description}</p>
                            <p class="task-topic">Topic: ${task.topic || 'N/A'}</p>
                        </div>
                        <div class="flex flex-col items-end space-y-1 flex-shrink-0">
                            <button class="add-to-today-btn icon-button text-yellow-500 hover:text-yellow-600" title="Add to Today's Focus"><i class="fas fa-star"></i></button>
                            <button class="edit-overall-task icon-button" title="Edit Task"><i class="fas fa-edit"></i></button>
                            <button class="delete-overall-task icon-button danger" title="Delete Task"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                    ${task.notes ? `<div class="task-notes-display"><strong>Notes:</strong><br>${task.notes.replace(/\n/g, '<br>')}</div>` : ''}
                </div>
            `);
            $taskList.append($taskItem);
        });
        updateDashboard();
    }

    function renderTodayTasks() {
        const $taskList = $('#todayTaskList').empty();
         if (todayTasks.length === 0) {
            $taskList.html('<p class="text-sm text-slate-500 px-1">No tasks for today. Add some or move from your overall plan!</p>');
        }
        todayTasks.forEach(task => {
            const isCompleted = task.completed;
            const $taskItem = $(`
                <div class="task-item ${isCompleted ? 'completed' : ''} cursor-grab" data-id="${task.id}">
                    <div class="flex justify-between items-start">
                        <div class="flex-grow mr-3">
                            <div class="flex items-center mb-1">
                                <input type="checkbox" id="cb-${task.id}" class="toggle-today-task-complete mr-3" ${isCompleted ? 'checked' : ''}>
                                <label for="cb-${task.id}" class="task-subject cursor-pointer">${task.subject || 'General Task'}</label>
                            </div>
                            <p class="task-description ml-7">${task.description}</p> <p class="task-topic ml-7">Topic: ${task.topic || 'N/A'}</p> </div>
                        <div class="flex flex-col items-end space-y-1 flex-shrink-0">
                             <button class="edit-today-task icon-button" title="Edit Task"><i class="fas fa-edit"></i></button>
                             <button class="delete-today-task icon-button danger" title="Delete Task"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                     ${task.notes ? `<div class="task-notes-display ml-7"><strong>Notes:</strong><br>${task.notes.replace(/\n/g, '<br>')}</div>` : ''}
                    <div class="timer-controls ${isCompleted ? 'hidden' : ''}">
                        <span class="font-mono" id="timer-${task.id}">${formatTime(task.totalElapsedTime)}</span>
                        <button class="timer-toggle-btn notion-button notion-button-secondary" data-task-id="${task.id}">
                            <i class="fas ${task.isTracking ? 'fa-pause' : 'fa-play'}"></i> ${task.isTracking ? 'Pause' : 'Start'}
                        </button>
                    </div>
                </div>
            `);
            $taskList.append($taskItem);
            if (task.isTracking) {
                startTaskTimer(task.id, true);
            }
        });
        updateDashboard();
    }

    // --- Exam Functions (Logic identical, minor class changes in renderExams reflected) ---
    $('#addExamBtn').click(() => {
        currentEditingExamId = null;
        $('#examModalTitle').text('Add New Exam');
        $('#examId').val('');
        $('#examName').val('');
        $('#examDate').val('');
        openModal('examModal');
    });

    $('#saveExamBtn').click(() => {
        const name = $('#examName').val().trim();
        const date = $('#examDate').val();
        if (!name || !date) {
            // Replace alert with a more subtle notification
            $('#confirmationModalTitle').text("Input Required");
            showConfirmation("Please enter both exam name and date.", () => {}); 
            $('#confirmAction').hide(); 
            $('#cancelConfirmation').text("OK"); 
            $('#cancelConfirmation').off('click').on('click', () => { 
                closeModal('confirmationModal');
                // Reset confirmation modal buttons for next use
                $('#confirmAction').show();
                $('#cancelConfirmation').text("Cancel");
                 $('#cancelConfirmation').off('click').on('click', () => closeModal('confirmationModal'));

            });
            return;
        }

        if (currentEditingExamId) {
            const exam = exams.find(e => e.id === currentEditingExamId);
            if (exam) {
                exam.name = name;
                exam.date = date;
            }
        } else {
            exams.push({ id: generateId(), name, date });
        }
        saveData();
        renderExams();
        closeModal('examModal');
        currentEditingExamId = null;
    });

    $('#examList').on('click', '.edit-exam', function() {
        currentEditingExamId = $(this).closest('.exam-item').data('id');
        const exam = exams.find(e => e.id === currentEditingExamId);
        if (exam) {
            $('#examModalTitle').text('Edit Exam');
            $('#examId').val(exam.id);
            $('#examName').val(exam.name);
            $('#examDate').val(exam.date);
            openModal('examModal');
        }
    });

    $('#examList').on('click', '.delete-exam', function() {
        const examId = $(this).closest('.exam-item').data('id');
        $('#confirmationModalTitle').text("Confirm Deletion"); // Set specific title
        showConfirmation('Are you sure you want to delete this exam?', () => {
            exams = exams.filter(e => e.id !== examId);
            if (examCountdownIntervals[examId]) {
                clearInterval(examCountdownIntervals[examId]);
                delete examCountdownIntervals[examId];
            }
            saveData();
            renderExams();
        });
    });

    function updateExamCountdown(examId) {
        const exam = exams.find(e => e.id === examId);
        if (!exam) return;

        if (examCountdownIntervals[examId]) {
            clearInterval(examCountdownIntervals[examId]);
        }

        const $countdownEl = $(`#countdown-${exam.id}`);
        if (!$countdownEl.length) return;

        function update() {
            const now = moment();
            const examDate = moment(exam.date);
            if (examDate.isBefore(now, 'day')) { 
                $countdownEl.text('This exam has passed.');
                $countdownEl.removeClass('is-upcoming').addClass('is-past');
                if (examCountdownIntervals[examId]) clearInterval(examCountdownIntervals[examId]);
                return;
            }
             if (examDate.isSame(now, 'day')) { 
                $countdownEl.text('Exam is Today!');
                $countdownEl.removeClass('is-past').addClass('is-upcoming font-bold');
                if (examCountdownIntervals[examId]) clearInterval(examCountdownIntervals[examId]);
                return;
            }


            const duration = moment.duration(examDate.diff(now));
             if (duration.asMilliseconds() <= 0) { 
                 $countdownEl.text('Exam has passed or is imminent!');
                 if (examCountdownIntervals[examId]) clearInterval(examCountdownIntervals[examId]);
                 return;
            }

            const days = Math.floor(duration.asDays());
            const hours = duration.hours();
            const minutes = duration.minutes();
            let countdownString = "";
            if (days > 0) countdownString += `${days}d `;
            if (hours > 0 || days > 0) countdownString += `${hours}h `; 
            countdownString += `${minutes}m remaining`;
            $countdownEl.text(countdownString);
            $countdownEl.removeClass('is-past').addClass('is-upcoming');
        }
        update();
        examCountdownIntervals[examId] = setInterval(update, 60000); 
    }


    // --- Task Functions (Logic identical) ---
    function openTaskModal(type, taskId = null) {
        currentEditingTaskListType = type;
        currentEditingTaskId = taskId;

        $('#taskModalTitle').text(taskId ? `Edit Task` : `Add ${type === 'today' ? "Today's Focus" : 'Overall'} Task`);
        $('#taskListType').val(type);
        $('#taskId').val(taskId || '');

        if (taskId) {
            const taskList = type === 'overall' ? overallTasks : todayTasks;
            const task = taskList.find(t => t.id === taskId);
            if (task) {
                $('#taskSubject').val(task.subject);
                $('#taskDescription').val(task.description);
                $('#taskTopic').val(task.topic);
                $('#taskNotes').val(task.notes);
            }
        } else {
            $('#taskSubject').val('');
            $('#taskDescription').val('');
            $('#taskTopic').val('');
            $('#taskNotes').val('');
        }
        openModal('taskModal');
    }

    $('#addOverallTaskBtn').click(() => openTaskModal('overall'));
    $('#addTodayTaskBtn').click(() => openTaskModal('today'));

    $('#saveTaskBtn').click(() => {
        const subject = $('#taskSubject').val().trim();
        const description = $('#taskDescription').val().trim();
        const topic = $('#taskTopic').val().trim();
        const notes = $('#taskNotes').val().trim();
        const type = $('#taskListType').val();

        if (!description) {
            $('#confirmationModalTitle').text("Input Required");
            showConfirmation("Task description cannot be empty.", () => {});
            $('#confirmAction').hide();
            $('#cancelConfirmation').text("OK");
            $('#cancelConfirmation').off('click').on('click', () => {
                closeModal('confirmationModal');
                $('#confirmAction').show();
                $('#cancelConfirmation').text("Cancel");
                $('#cancelConfirmation').off('click').on('click', () => closeModal('confirmationModal'));
            });
            return;
        }

        const taskData = { subject, description, topic, notes };

        if (currentEditingTaskId) {
            const taskList = type === 'overall' ? overallTasks : todayTasks;
            const task = taskList.find(t => t.id === currentEditingTaskId);
            if (task) {
                Object.assign(task, taskData);
            }
        } else {
            taskData.id = generateId();
            taskData.createdAt = new Date().toISOString();
            if (type === 'overall') {
                overallTasks.push(taskData);
            } else {
                taskData.completed = false;
                taskData.completedAt = null;
                taskData.totalElapsedTime = 0;
                taskData.isTracking = false;
                taskData.startedAt = null;
                todayTasks.push(taskData);
            }
        }

        saveData();
        if (type === 'overall') renderOverallTasks();
        else renderTodayTasks();
        closeModal('taskModal');
        currentEditingTaskId = null;
        currentEditingTaskListType = null;
    });

    $('#overallTaskList').on('click', '.edit-overall-task', function() {
        const taskId = $(this).closest('.task-item').data('id');
        openTaskModal('overall', taskId);
    });

    $('#overallTaskList').on('click', '.delete-overall-task', function() {
        const taskId = $(this).closest('.task-item').data('id');
        $('#confirmationModalTitle').text("Confirm Deletion");
        showConfirmation('Are you sure you want to delete this overall task?', () => {
            overallTasks = overallTasks.filter(t => t.id !== taskId);
            saveData();
            renderOverallTasks();
        });
    });

    $('#overallTaskList').on('click', '.add-to-today-btn', function() {
        const $button = $(this);
        const taskId = $button.closest('.task-item').data('id');
        const overallTask = overallTasks.find(t => t.id === taskId);
        if (overallTask) {
            const newTodayTask = {
                ...overallTask,
                id: generateId(),
                originalOverallId: overallTask.id,
                completed: false,
                completedAt: null,
                totalElapsedTime: 0,
                isTracking: false,
                startedAt: null,
                createdAt: new Date().toISOString()
            };
            todayTasks.push(newTodayTask);
            saveData();
            renderTodayTasks();
            $button.html('<i class="fas fa-check text-green-500"></i>').prop('disabled', true);
            setTimeout(() => {
                 $button.html('<i class="fas fa-star"></i>').prop('disabled', false);
            }, 1500);
        }
    });

    $('#todayTaskList').on('click', '.edit-today-task', function() {
        const taskId = $(this).closest('.task-item').data('id');
        openTaskModal('today', taskId);
    });

    $('#todayTaskList').on('click', '.delete-today-task', function() {
        const taskId = $(this).closest('.task-item').data('id');
        $('#confirmationModalTitle').text("Confirm Deletion");
        showConfirmation("Are you sure you want to delete this task from today's focus?", () => {
            stopTaskTimer(taskId, true);
            todayTasks = todayTasks.filter(t => t.id !== taskId);
            saveData();
            renderTodayTasks();
        });
    });

    $('#todayTaskList').on('change', '.toggle-today-task-complete', function() {
        const taskId = $(this).closest('.task-item').data('id');
        const task = todayTasks.find(t => t.id === taskId);
        if (task) {
            task.completed = $(this).is(':checked');
            task.completedAt = task.completed ? new Date().toISOString() : null;
            if (task.completed && task.isTracking) {
                stopTaskTimer(taskId);
            }
            saveData();
            renderTodayTasks();
        }
    });


    // --- Time Tracking for Today's Tasks (Logic identical) ---
    $('#todayTaskList').on('click', '.timer-toggle-btn', function() {
        const taskId = $(this).data('taskId');
        const task = todayTasks.find(t => t.id === taskId);
        if (!task) return;

        if (task.isTracking) {
            stopTaskTimer(taskId);
        } else {
            startTaskTimer(taskId);
        }
        $(this).html(`<i class="fas ${task.isTracking ? 'fa-pause' : 'fa-play'}"></i> ${task.isTracking ? 'Pause' : 'Start'}`);
        saveData();
    });

    function startTaskTimer(taskId, isContinuation = false) {
        const task = todayTasks.find(t => t.id === taskId);
        if (!task || task.isTracking) return;

        task.isTracking = true;
        if (!isContinuation || !task.startedAt) { 
             task.startedAt = Date.now();
        }


        if (taskTimerIntervals[taskId]) clearInterval(taskTimerIntervals[taskId]);

        taskTimerIntervals[taskId] = setInterval(() => {
            if (!task.startedAt) return;
            const currentTime = Date.now();
            const sessionElapsedTime = currentTime - task.startedAt;
            const currentTotalDisplayTime = (task.totalElapsedTime || 0) + sessionElapsedTime;
            $(`#timer-${taskId}`).text(formatTime(currentTotalDisplayTime));
        }, 1000);

        const $button = $(`.timer-toggle-btn[data-task-id="${taskId}"]`);
        $button.html('<i class="fas fa-pause"></i> Pause');
    }

    function stopTaskTimer(taskId, isDeleting = false) {
        const task = todayTasks.find(t => t.id === taskId);
        if (!task || !task.isTracking) {
            if (taskTimerIntervals[taskId]) clearInterval(taskTimerIntervals[taskId]);
            if (task) task.isTracking = false;
            if (!isDeleting) {
                const $button = $(`.timer-toggle-btn[data-task-id="${taskId}"]`);
                if ($button.length) $button.html('<i class="fas fa-play"></i> Start');
            }
            return;
        }

        const stoppedAt = Date.now();
        if (task.startedAt) { 
            task.totalElapsedTime = (task.totalElapsedTime || 0) + (stoppedAt - task.startedAt);
        }
        task.isTracking = false;
        task.startedAt = null;

        if (taskTimerIntervals[taskId]) {
            clearInterval(taskTimerIntervals[taskId]);
            delete taskTimerIntervals[taskId];
        }
        
        if (!isDeleting) {
            $(`#timer-${taskId}`).text(formatTime(task.totalElapsedTime));
            const $button = $(`.timer-toggle-btn[data-task-id="${taskId}"]`);
            if ($button.length) $button.html('<i class="fas fa-play"></i> Start');
        }
        saveData();
    }


    // --- Dashboard Update (Updated for new stat card structure) ---
    function updateDashboard() {
        const $dashboardContent = $('#dashboard-content').empty();

        // 1. Upcoming Exams Count
        const upcomingExams = exams.filter(exam => moment(exam.date).isSameOrAfter(moment(), 'day'));
        $dashboardContent.append(`
            <div class="stat-card">
                <i class="fas fa-calendar-alt stat-card-icon text-red-500"></i>
                <span class="stat-card-value">${upcomingExams.length}</span>
                <span class="stat-card-label">Upcoming Exam${upcomingExams.length !== 1 ? 's' : ''}</span>
            </div>
        `);

        // 2. Closest Exam
        let closestExamName = 'N/A';
        let closestExamCountdown = '';
        if (upcomingExams.length > 0) {
            const sortedUpcomingExams = [...upcomingExams].sort((a, b) => new Date(a.date) - new Date(b.date));
            const closestExam = sortedUpcomingExams[0];
            closestExamName = closestExam.name;
            const examDate = moment(closestExam.date);
            const now = moment();
            if (examDate.isSame(now, 'day')) {
                closestExamCountdown = "Today!";
            } else if (examDate.isBefore(now)) {
                closestExamCountdown = "Passed";
            } else {
                const duration = moment.duration(examDate.diff(now));
                closestExamCountdown = `${Math.floor(duration.asDays())}d ${duration.hours()}h left`;
            }
        }
        $dashboardContent.append(`
            <div class="stat-card">
                <i class="fas fa-bell stat-card-icon text-orange-500"></i>
                <span class="stat-card-value truncate w-full" title="${closestExamName}">${closestExamName.length > 15 ? closestExamName.substring(0,12)+"..." : closestExamName}</span>
                <span class="stat-card-label">Closest Exam</span>
                <span class="stat-card-extra">${closestExamCountdown || 'No upcoming'}</span>
            </div>
        `);

        // 3. Tasks Completed Today
        const todayString = moment().format('YYYY-MM-DD');
        const tasksCompletedTodayCount = todayTasks.filter(task =>
            task.completed && task.completedAt && moment(task.completedAt).format('YYYY-MM-DD') === todayString
        ).length;
        $dashboardContent.append(`
            <div class="stat-card">
                <i class="fas fa-check-circle stat-card-icon text-green-500"></i>
                <span class="stat-card-value">${tasksCompletedTodayCount}</span>
                <span class="stat-card-label">Tasks Done Today</span>
            </div>
        `);

        // 4. Today's Tasks by Subject
        let subjectListHtml = '<li class="text-xs text-slate-500">No tasks for today.</li>';
        if (todayTasks.length > 0) {
            const subjectCounts = todayTasks.reduce((acc, task) => {
                const subject = task.subject || 'Uncategorized';
                acc[subject] = (acc[subject] || 0) + 1;
                return acc;
            }, {});
            if (Object.keys(subjectCounts).length > 0) {
                subjectListHtml = Object.entries(subjectCounts)
                    .map(([subject, count]) => `<li><span class="font-medium text-slate-700">${subject}:</span> <span class="text-slate-500">${count} task${count !== 1 ? 's' : ''}</span></li>`)
                    .join('');
            }
        }
         $dashboardContent.append(`
            <div class="stat-card items-start" id="db-today-tasks-by-subject-card"> <div class="flex items-center mb-2">
                    <i class="fas fa-tags stat-card-icon text-blue-500 !mb-0 mr-2 !text-xl"></i>
                    <span class="stat-card-label !mt-0 !text-base font-medium">Today's Tasks by Subject</span>
                </div>
                <ul id="db-today-tasks-by-subject" class="w-full space-y-1">
                    ${subjectListHtml}
                </ul>
            </div>
        `);
    }


    // --- SortableJS Initialization (Identical) ---
    const overallTaskListEl = document.getElementById('overallTaskList');
    Sortable.create(overallTaskListEl, {
        animation: 150,
        ghostClass: 'sortable-ghost',
        handle: '.task-item', 
        onEnd: function(evt) {
            const itemEl = evt.item;
            const taskId = $(itemEl).data('id');
            const newIndex = evt.newIndex;
            const oldIndex = evt.oldIndex;
            const task = overallTasks.find(t => t.id === taskId);
            if (task) {
                overallTasks.splice(oldIndex, 1);
                overallTasks.splice(newIndex, 0, task);
                saveData();
            }
        }
    });

    const todayTaskListEl = document.getElementById('todayTaskList');
    Sortable.create(todayTaskListEl, {
        animation: 150,
        ghostClass: 'sortable-ghost',
        handle: '.task-item',
        onEnd: function(evt) {
            const itemEl = evt.item;
            const taskId = $(itemEl).data('id');
            const newIndex = evt.newIndex;
            const oldIndex = evt.oldIndex;
            const task = todayTasks.find(t => t.id === taskId);
            if (task) {
                todayTasks.splice(oldIndex, 1);
                todayTasks.splice(newIndex, 0, task);
                saveData();
            }
        }
    });


    // --- Initial Load ---
    loadData();
    renderExams();
    renderOverallTasks();
    renderTodayTasks();
    // updateDashboard is called by render functions.

    // --- beforeunload handler (Identical) ---
    $(window).on('beforeunload', function() {
        todayTasks.forEach(task => {
            if (task.isTracking && task.startedAt) {
                const stoppedAt = Date.now();
                task.totalElapsedTime = (task.totalElapsedTime || 0) + (stoppedAt - task.startedAt);
                task.isTracking = false;
                task.startedAt = null;
            }
        });
        saveData();
    });

});
</script>
</body>
</html>
