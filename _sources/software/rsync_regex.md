# Using RSync with Regex

Here is an example of a
useful command[^f1] to download files from osc to your local machine:

```bash
``rsync --dry-run --progress -rv --prune-empty-dirs \
      --exclude='**/*allTree*'\
      --exclude='**/Simulate*'\
      osc:/fs/ess/PAS2608/Jason_test_runs/AIII* \
      .
```
+   This will copy files that starts with "AIII" from the directory
    `/fs/ess/PAS2608/Jason_test_runs` on `osc` to the current directory `.`

+   This script assumes that you have {ref}`set up your ssh config<osc_ssh_setup>`.
    Otherwise instead of `osc` you need to type in 
    ```
    username@pitzer.osc.edu
    ```
    and maybe enter your password afterwards.

+   The `--dry-run` flag tells `rsync` to not actually copy the files yet.
    There will be a list (might take a while to generate) at the end of the
    dry run for you to see if all the desired files are included (or excluded
    in this case).

+   `-r` stands for recursive. `-v` stands for `verbose` (might be the same thing
    as `--progress`?) 


[^f1]: See [stackoverflow](https://stackoverflow.com/questions/74454117/rsync-doesnt-want-to-sync-any-files-no-errors) for more information.

