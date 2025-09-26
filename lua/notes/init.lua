-- Author: https://github.com/linkarzu
local notes = {}

-- parse date line and generate file path components for the daily note
local function parse_date_line(date_line)
  local home = os.getenv("HOME")
  local year, month, day, weekday = date_line:match("%[%[(%d+)%-(%d+)%-(%d+)%-(.+)%]%]")
  if not (year and month and day and weekday) then
    print("No valid date found in the line")
    return nil
  end
  local month_abbr = os.date("%b", os.time({ year = year, month = month, day = day }))
  local note_dir = string.format("%s/daily-notes/%s/%s-%s", home, year, month, month_abbr)
  local note_name = string.format("%s-%s-%s-%s.md", year, month, day, weekday)
  return note_dir, note_name
end

-- get the full path of the daily note
local function get_daily_note_path(date_line)
  local note_dir, note_name = parse_date_line(date_line)
  if not note_dir or not note_name then
    return nil
  end
  return note_dir .. "/" .. note_name
end

function notes.create_daily_note(date_line)
  local full_path = get_daily_note_path(date_line)
  if not full_path then
    return
  end
  local note_dir = full_path:match("(.*/)") -- Extract directory path from full path
  -- Ensure the directory exists
  vim.fn.mkdir(note_dir, "p")
  -- Check if the file exists and create it if it doesn't
  if vim.fn.filereadable(full_path) == 0 then
    local file = io.open(full_path, "w")
    if file then
      file:write(
        "# Contents\n\n<!-- toc -->\n\n- [Daily note](#daily-note)\n\n<!-- tocstop -->\n\n## Daily note\n\n## TIL\n"
      )
      file:close()
      vim.cmd("edit " .. vim.fn.fnameescape(full_path))
      vim.cmd("bd!")
      vim.api.nvim_echo({
        { "CREATED DAILY NOTE\n", "WarningMsg" },
        { full_path, "WarningMsg" },
      }, false, {})
    else
      print("Failed to create file: " .. full_path)
    end
  else
    print("Daily note already exists: " .. full_path)
  end
end

function notes.switch_to_daily_note(date_line)
  local full_path = get_daily_note_path(date_line)
  if not full_path then
    return
  end
  notes.create_daily_note(date_line)
  vim.cmd("edit " .. vim.fn.fnameescape(full_path))
end
-- Extract the Y-M-D parts from the current filename
local function current_file_date()
  local fname = vim.fn.expand("%:t")
  local y, m, d = fname:match("^(%d+)%-(%d+)%-(%d+)%-%w+%.md$")
  return y, m, d
end

-- Create N consecutive daily notes, starting tomorrow
function notes.create_next_n_days(n)
  local y, m, d = current_file_date()
  if not (y and m and d) then
    vim.api.nvim_echo({ { "Current file is not a valid daily note filename", "ErrorMsg" } }, false, {})
    return
  end
  local base_ts = os.time({ year = y, month = m, day = d })
  for i = 1, n do
    local t = os.date("*t", base_ts + 86400 * i)
    local link = string.format(
      "[[%04d-%02d-%02d-%s]]",
      t.year,
      t.month,
      t.day,
      os.date("%A", os.time({ year = t.year, month = t.month, day = t.day }))
    )
    notes.create_daily_note(link)
  end
end

return notes
