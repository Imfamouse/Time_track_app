# Схема данных высокого уровня

## Основные таблицы
- `users`
  - `id` (PK, UUID)
  - `full_name`
  - `job_title`
  - `account`
  - `status` (active/inactive)
  - `category` (enum: OPP/ADM)
  - `created_at`, `updated_at`

- `departments`
  - `id` (PK, UUID)
  - `name`
  - `code`
  - `manager_id` (FK → users.id)

- `department_members`
  - `department_id` (FK)
  - `user_id` (FK)
  - `role` (enum: member/manager/deputy)
  - PK (`department_id`, `user_id`)

- `projects`
  - `id` (PK, UUID)
  - `request_number`
  - `name`
  - `description`
  - `customer`
  - `product`
  - `project_manager_id` (FK → users.id)
  - `planned_start`, `planned_finish`
  - `actual_start`, `actual_finish`
  - `status` (enum: planned/in_progress/completed)

- `project_products`
  - `project_id`
  - `product_name`

- `tasks`
  - `id` (PK, UUID)
  - `project_id` (FK)
  - `title`
  - `description`
  - `priority` (enum: low/medium/high/critical)
  - `status` (enum: planned/in_progress/completed/blocked)
  - `planned_hours`
  - `actual_hours`
  - `remaining_hours`
  - `planned_start`, `planned_finish`
  - `actual_start`, `actual_finish`
  - `assigned_department_id` (FK → departments.id)
  - `current_assignee_id` (FK → users.id, nullable)
  - `is_summary` (bool)
  - `parent_task_id` (FK → tasks.id, nullable)

- `task_assignments`
  - `id` (PK, UUID)
  - `task_id` (FK → tasks.id)
  - `user_id` (FK → users.id)
  - `assigned_at`
  - `unassigned_at`

- `time_entries`
  - `id` (PK, UUID)
  - `task_id`
  - `user_id`
  - `work_date`
  - `hours`
  - `comment`
  - `status` (draft/submitted/approved/rejected)
  - `submitted_at`, `approved_at`, `rejected_at`
  - `approved_by` (FK → users.id)

- `time_reports`
  - `id` (PK, UUID)
  - `user_id`
  - `period_start`
  - `period_end`
  - `status`
  - `submitted_at`, `approved_at`, `rejected_at`
  - `approved_by`
  - `rejection_reason`

- `report_entries`
  - `report_id` (FK → time_reports.id)
  - `time_entry_id` (FK → time_entries.id)

- `notifications`
  - `id`
  - `recipient_id`
  - `type`
  - `payload` (JSONB)
  - `is_read`
  - `created_at`

- `audit_log`
  - `id`
  - `entity_type`
  - `entity_id`
  - `action`
  - `performed_by`
  - `performed_at`
  - `before` (JSONB)
  - `after` (JSONB)

## Связи
- `users` ↔ `departments` через `department_members` (многие-ко-многим).
- `projects` ↔ `tasks` (один-ко-многим).
- `tasks` ↔ `task_assignments` (история исполнителей).
- `tasks` ↔ `time_entries` (один-ко-многим).
- `time_reports` агрегируют `time_entries` через `report_entries`.
- `notifications` и `audit_log` связаны с пользователями по `performed_by`/`recipient_id`.

## Индексы и оптимизация
- Составные индексы по (`task_id`, `user_id`, `work_date`) для `time_entries`.
- Индекс по `status` и `period_start` для `time_reports`.
- Индекс по `recipient_id`, `is_read` для `notifications`.
- Использование партиционирования по `work_date` для `time_entries` (недели/месяцы) обсуждается отдельно.

## Предстоящая работа
- Детализировать атрибуты для отчётных таблиц.
- Определить view/материализованные view для агрегатов отчётности.
