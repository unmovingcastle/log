# How to Set up Github credentials on Linux/macOS

As of August 13, 2021, You can no longer use your Github password for Git operations through
terminals. Additionally, PUEO does not allow access through personal access tokens.
Therefore, before interacting with any pueo repo, you must set up `ssh` on your computer.

The following tutorial is based on this [video](https://www.youtube.com/watch?v=8X4u9sca3Io).

## Generating an SSH key in the terminal

Enter 
```bash
ssh-keygen -t ed25519 -C your-email@example.com
```
where `your-email@example.com` is the email you use to register for Github.
The `-t ed25519` option indicates that we will use this particular type of encryption for
the key.

Run the above command, press {kbd}`Enter` if you wish to store the key at the default location.
Press {kbd}`Enter}` again if you want to skip making a passphrase.

## Activate the SSH agent
Run the following command
```bash
eval "$(ssh-agent -s)"
```
to start the ssh agent.
The terminal should return something like
```
Agent pid 12889
```

## Edit ssh config file
Open/create an ssh configuration file through any text editor. For instance,
```bash
vim ~/.ssh/config
```

Put the following content in the configuration file:
```
Host *
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_ed25519
```

(quit vim by pressing {kbd}`Esc`, then {kbd}`:`, then {kbd}`w`+{kbd}`q`.

## Add Key to Agent

```bash
ssh-add ~/.ssh/id_ed25519
```

## Inform Github
Go to [Github SSH and GPG keys setting page](https://github.com/settings/keys) and click 
on the "New SSH key" button on the top right corner. 
Enter whatever you want for the Title.

Now go back to the terminal and type
```bash
cat ~/.ssh/id_ed25519.pub
```
```{admonition} cat
:class: dropdown, seealso
[cat](https://www.geeksforgeeks.org/cat-command-in-linux-with-examples/) 
is a command that reads the content of a text file.
Some (crazy) people rebinds the command to `dog`.
```

```{important}
Make sure you include the `.pub`! It represents the public key.
```

Copy whatever `cat` returns on your terminal to the Github page and click "Add SSH key".
Github will ask for your password for confirmation.

## Confirmation

Check that the key works through
```bash
ssh -T git@github.com
```
(and enter `yes` if the computer asks you whether or not to continue connecting to github.com)
Don't worry about the `-T` option. Basically, it suppresses some messages.

If you see a greeting message like 
> Hi XXX! You've successfully authenticated, but GitHub does not provide shell access.

it means you have suceeded.
