
#set page(paper: "a4", margin: 1cm)
#set text(font: "DejaVu Sans Mono", size: 8.5pt)

#let columns = ("Time", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

// radix color 8
#let red = color.rgb("#F4A9AA")
#let orange = color.rgb("#F5AE73")
#let yellow = color.rgb("#D5AE39")
#let green = color.rgb("#5BB98B")
#let blue = color.rgb("#5EB1EF")
#let purple = color.rgb("#BE93E4")
#let white = color.rgb("#FFFFFF")

// times from 05:00 to 23:00, in 30 minutes intervals
#let starting_hour = 5
#let ending_hour = 20
#let hour_to_time = (hour) => (str(hour) + ":00", str(hour) + ":30")
#let times = (range(ending_hour - starting_hour).map(i => hour_to_time(starting_hour + i)).flatten()) + (str(ending_hour) + ":00",)
#let time_cells = times.enumerate().map(t => table.cell(x: 0, y: t.at(0) + 1, t.at(1)))

// Bold top row.
#show table.cell.where(y: 0): set text(weight: "bold")
// Center content in every cell.
#show table.cell: set align(center + horizon)

// cell function
#let block = (color, start_hour, end_hour, day_index, content) => {
  let start_row = int((start_hour - starting_hour) * 2)
  let end_row = int((end_hour - starting_hour) * 2)
  table.cell(
    fill: color,
    x: day_index + 1,
    y: start_row + 1,
    rowspan: end_row - start_row,
    [
      #set text(weight: "bold", size: 10pt)
      #content
    ]
  )
}

// blocks on days
#let m_block = (color, start_hour, end_hour, content) => block(color, start_hour, end_hour, 0, content)
#let t_block = (color, start_hour, end_hour, content) => block(color, start_hour, end_hour, 1, content)
#let w_block = (color, start_hour, end_hour, content) => block(color, start_hour, end_hour, 2, content)
#let th_block = (color, start_hour, end_hour, content) => block(color, start_hour, end_hour, 3, content)
#let f_block = (color, start_hour, end_hour, content) => block(color, start_hour, end_hour, 4, content)

#let god_time = red;
#let work = green;
#let c_work = blue;
#let personal = orange;
#let food = purple;
#let community = yellow;
#let free = white;

#let event_cells = (
  m_block(god_time, 5, 7, "Prayer"),
  m_block(personal, 7, 8, "Preparing for the day"),
  m_block(god_time, 8, 9, "Worship"),
  m_block(personal, 9, 10.5, "Personal Study"),
  m_block(work, 10.5, 13.5, "Professional Work"),
  m_block(food, 13.5, 14.5, "Lunch"),
  m_block(work, 14.5, 16.5, "Professional Work"),
  m_block(free, 16.5, 17.5, "Free Time"),
  m_block(food, 17.5, 18, "Dinner"),
  m_block(community, 18, 20, "Solid Ground Meeting"),

  t_block(god_time, 5, 7, "Prayer"),
  t_block(personal, 7, 8, "Preparing for the day"),
  t_block(god_time, 8, 9, "Prayer"),
  t_block(c_work, 9, 12.5, "Solid Ground Work"),
  t_block(food, 12.5, 13.5, "Lunch"),
  t_block(c_work, 13.5, 15, "Solid Ground Work"),
  t_block(personal, 15, 16.5, "Personal / Group Study"),
  t_block(c_work, 16.5, 18.5, "Cooking for the Community Dinner"),
  t_block(community, 18.5, 20, "Community Dinner"),
  
  w_block(god_time, 5, 7, "Prayer"),
  w_block(personal, 7, 8, "Preparing for the day"),
  w_block(god_time, 8, 9, "Intercession"),
  w_block(work, 9, 13.5, "Professional Work"),
  w_block(food, 13.5, 14.5, "Lunch"),
  w_block(work, 14.5, 16.5, "Professional Work"),
  w_block(free, 16.5, 18.5, "Free Time"),
  w_block(community, 18.5, 20, "Community Dinner"),

  th_block(red, 5, 7, "Prayer"),
  th_block(orange, 7, 8, "Preparing for the day"),
  th_block(red, 8, 9, "Devotional"),
  th_block(c_work, 9, 12.5, "Solid Ground Work"),
  th_block(food, 12.5, 13.5, "Lunch"),
  th_block(c_work, 13.5, 15, "Solid Ground Work"),
  th_block(personal, 15, 17.5, "Personal Study"),
  th_block(c_work, 17.5, 18.5, "Preparing for Housechurch"),
  th_block(community, 18.5, 21, "Housechurch"),

  f_block(red, 5, 7, "Prayer"),
  f_block(orange, 7, 8, "Preparing for the day"),
  f_block(red, 8, 9, "Worship"),
  f_block(work, 9, 13.5, "Professional Work"),
  f_block(food, 13.5, 14.5, "Lunch"),
  f_block(work, 14.5, 16.5, "Professional Work"),
  f_block(community, 16.5, 18, "Small Groups"),
  f_block(food, 18, 18.5, "Dinner"),
  f_block(white, 18.5, 20, "Free Time"),
)

#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header(..columns),
  ..time_cells,
  ..event_cells,
)
