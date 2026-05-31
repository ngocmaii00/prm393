import os
import subprocess
import time
import sys

# Configuration
FLUTTER_PATH = "/home/mavis/Downloads/flutter_linux_3.41.9-stable/flutter/bin/flutter"
WATCH_DIR = "lib"
EXTENSIONS = (".dart",)

def get_last_modified_time(directory):
    max_mtime = 0
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(EXTENSIONS):
                mtime = os.path.getmtime(os.path.join(root, file))
                if mtime > max_mtime:
                    max_mtime = mtime
    return max_mtime

def main():
    print(f"--- Starting Flutter with Auto-Reload (Watching {WATCH_DIR}) ---")
    
    # Start flutter run
    process = subprocess.Popen(
        [FLUTTER_PATH, "run", "-d", "linux"],
        stdin=subprocess.PIPE,
        stdout=sys.stdout,
        stderr=sys.stderr,
        text=True,
        bufsize=1
    )

    last_mtime = get_last_modified_time(WATCH_DIR)

    try:
        while process.poll() is None:
            time.sleep(0.1)  # Giảm xuống 0.1s để phát hiện nhanh hơn
            current_mtime = get_last_modified_time(WATCH_DIR)
            
            if current_mtime > last_mtime:
                print(f"\n[Watcher] Change detected! Triggering Hot Reload...")
                process.stdin.write("r\n")
                process.stdin.flush()
                last_mtime = current_mtime
                
    except KeyboardInterrupt:
        print("\n[Watcher] Stopping...")
        process.terminate()
    finally:
        if process.poll() is None:
            process.terminate()

if __name__ == "__main__":
    main()
