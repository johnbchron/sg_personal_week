
#set page(paper: "a4", flipped: true, margin: 1cm)
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

#let event_cells = (
  ..range(0, 5).map(day => block(red, 5, 7, day, "Prayer")),
  ..range(0, 5).map(day => block(orange, 7, 8, day, "Preparing for the day")),
  ..(("Worship", "Prayer", "Intercession", "Devotional", "Worship").enumerate().map(e => {
    let day = e.at(0)
    let event = e.at(1)
    block(red, 8, 9, day, event)
  })),

  ..((0, 2, 4).map(day => {(
    // block(green, 9, 13.5, day, "Professional\nWork"),
    block(purple, 13.5, 14.5, day, "Lunch"),
    block(green, 14.5, 16.5, day, "Professional\nWork"),
  )}).flatten()),
  block(orange, 9, 10.5, 0, "Personal\nStudy"),
  block(green, 10.5, 13.5, 0, "Professional\nWork"),
  block(green, 9, 13.5, 2, "Professional\nWork"),
  block(green, 9, 13.5, 4, "Professional\nWork"),
  ..((1, 3).map(day => {(
    block(blue, 9, 12.5, day, "Farm\nWork"),
    block(purple, 12.5, 13.5, day, "Lunch"),
    block(blue, 13.5, 15, day, "Farm\nWork"),
  )}).flatten()),
  block(orange, 15, 16.5, 1, "Personal\nStudy"),

  block(orange, 16.5, 17.5, 0, "Personal\nStudy"),
  block(purple, 17.5, 18, 0, "Dinner"),
  block(yellow, 18, 20, 0, "Solid Ground\nMeeting"),

  block(blue, 16.5, 18.5, 1, "Cooking for the\nCommunity Dinner"),
  block(yellow, 18.5, 20, 1, "Community\nDinner"),

  block(orange, 16.5, 18.5, 2, "Personal\nStudy"),
  block(yellow, 18.5, 20, 2, "Community\nDinner"),

  block(orange, 15, 17.5, 3, "Personal\nStudy"),
  block(blue, 17.5, 18.5, 3, "Preparing for\nHousechurch"),
  block(red, 18.5, 21, 3, "Housechurch"),

  block(orange, 16.5, 18, 4, "Personal\nStudy"),
  block(purple, 18, 18.5, 4, "Dinner"),
  block(white, 18.5, 20, 4, "Free Time"),
)

#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header(..columns),
  ..time_cells,
  ..event_cells,
)
