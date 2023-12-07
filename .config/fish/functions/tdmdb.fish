function tdmdb
    if test (count $argv) -lt 1
        printf "lpvtdmdb01.itap.purdue.edu"
        return
    else
        switch $argv[1]
            case backup
                cd "$HOME/Box Sync/db_backups/" && pg_dump -h lpvtdmdb01.itap.purdue.edu -U postgres -d tdmdb -Fc -Z 9 > $(date +%Y%m%d%H%M%S)-tdmdb.dump && ls -lrth | tail -n 1 && cd -
                return
            case "*";
                # Any other arguments passed
                return
        end
    end
end
