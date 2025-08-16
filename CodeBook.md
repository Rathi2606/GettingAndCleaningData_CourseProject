# Variables in `tidy_data.txt`

- `subject`: Participant ID (1-30)
- `activity`: Activity performed (WALKING, SITTING, etc.)
- **Measurements**: All columns are **averages** of:
  - Time/Frequency domain signals
  - Body/Gravity acceleration
  - Gyroscope data
  - Mean (`_Mean_`) and Standard Deviation (`_STD_`)
  - Units: Normalized to [-1, 1] (no units)

## Transformations
1. Raw data merged from 8 files.
2. 79 mean/std features extracted.
3. Activity IDs replaced with descriptive names.
4. Variable names expanded (e.g., `t` → `Time_`).
5. Grouped by subject/activity and averaged.
