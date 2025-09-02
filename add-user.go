package main

import (
    "bufio"
    "fmt"
    "os"
    "os/exec"
    "strconv"
    "strings"
    "time"
)

func writeLogf(format string, args ...any) {
    ts := time.Now().Format("2006-01-02 15:04:05")
    fmt.Fprintf(os.Stderr, "[%s] "+format, append([]any{ts}, args...)...)
}

func getUserInfo() string {
    in := bufio.NewReader(os.Stdin)
    fmt.Print("*** Welcome to sql injection ***\n")
    fmt.Print("Please enter name: ")
    line, _ := in.ReadString('\n')
    return strings.TrimSpace(line)
}

func getNewID() int {
    return os.Getpid()
}

func writeInfo(id int, info string) {
    // UNSAFE: build SQL dynamically from untrusted input
    query := fmt.Sprintf("INSERT INTO users VALUES (%d, '%s')", id, info)
    writeLogf("query: %s\n", query)

    // Execute via sqlite3 CLI to avoid external Go dependencies
    cmd := exec.Command("sqlite3", "users.sqlite", query)
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    if err := cmd.Run(); err != nil {
        fmt.Fprintf(os.Stderr, "SQL error: %v\n", err)
        os.Exit(1)
    }
}

func main() {
    info := getUserInfo()
    id := getNewID()
    // ensure id is used (silence potential warnings)
    _ = strconv.Itoa(id)
    writeInfo(id, info)
}
