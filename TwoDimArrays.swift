import Foundation

// Read file lines into an array
func fileToArray(_ path: String) -> [String] {
    do {
        // Try to read file content
        let content = try String(contentsOfFile: path, encoding: .utf8)
        // Create array of lines and return
        let lines = content.split(separator: "\n").map { String($0) }
        return lines
    } catch {
        // Print error case and return empty array
        print("Error: could not read \(path).")
        return []
    }
}

// Write 2D array to CSV file
func writeArrayToCsv(_ data: [[String]], _ filePath: String) {
    // Initialize csv string
    var csv = ""
    // Populate CSV
    for row in data {
        csv += row.joined(separator: ", ") + "\n"
    }
    // Try to write to file
    do {
        // Write to file
        try csv.write(toFile: filePath, atomically: true, encoding: .utf8)
        print("2D array successfully written to \(filePath)")
    } catch {
        // If error during write
        print("Error writing to CSV file: \(error)")
    }
}

// Random generator
func randomGrade() -> Int {
    // Generate random grade
    let grade = Int(Double.random(in: -1...1) * 10 + 75)
    return grade
}

// Read students and assignments
let students = fileToArray("students.txt")
let assignments = fileToArray("assignments.txt")

if !students.isEmpty && !assignments.isEmpty {
    // Make 2D array
    var grades = Array(
        repeating: Array(repeating: "", count: assignments.count + 1),
        count: students.count + 1
    )

    // Header
    grades[0][0] = "Names/Assignments"

    // Fill first column (students)
    for r in 1...students.count {
        grades[r][0] = students[r - 1]
    }

    // Fill first row (assignments)
    for c in 1...assignments.count {
        grades[0][c] = assignments[c - 1]
    }

    // Fill random grades
    for y in 1...students.count {
        for x in 1...assignments.count {
            grades[y][x] = String(randomGrade())
        }
    }

    // Export to CSV
    writeArrayToCsv(grades, "grades.csv")
}
