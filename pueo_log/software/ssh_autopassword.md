# How to: password-less ssh

If OSC allows public key authentication in the future, we would be able to
set up a public/private key-pair so that we don't have to type our password
each time we `ssh` into OSC. See {doc}`setting_up_github_ssh` for how to 
generate an ssh key pair. One could further use
```bash
ssh-copy-id -i path/to/your/PUBLIC_key.pub username@pitzer.osc.edu
```
to copy the public key onto OSC.


As of Oct 30, 2023, I have not been able to use key authentication to access
OSC. In the meantime, therefore, below is a workaround [^f1].

+ Create a file called `osc` using any editor you like.
+ Put the following content inside `osc`.

    ```bash
    #!/usr/bin/expect -f

    spawn ssh YOUR_USERNAME@pitzer.osc.edu

    expect "assword:"
    send "YOUR_PASSWORD\r"
    interact
    ```

+ Replace `YOUR_USERNAME` with your OSC username and `YOUR_PASSWORD` with
  your OSC password.

    ```{warning}
    Do make sure to keep the `\r` (after `YOUR_PASSWORD`).
    Alternatively, it could be a `\n` (newline character).
    ```

    ```{admonition} regarding the expected
    :class: seealso, dropdown
    The `assword:` is intentional and not a typo, since what we are expecting
    could technically be `P`assword or `p`assword. See [^f1].
    ```

+ At this point, you want to **make sure you are the only person that is
    authorized to execute this script.** 
    Exit the text editor and in the terminal, change access to file using
    ```bash
    chmod 700 osc
    ```

+ You can set an alias in your `.bashrc` (or `.zshrc`) to execute this script,
    or you could place it in a directory where your computer automatically
    looks. For instance, on my mac, the path of this file is at
    ```
    /usr/local/bin/osc
    ```

+ And now whenever I type `osc`, I `ssh` into OSC without having to type my
    password!



[^f1]: [source](https://stackoverflow.com/a/16928662)


