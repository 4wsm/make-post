# README

## NAME

`make-post` - shell script for jekyll post creating automation

## SYNOPSIS

`jekyll_post.sh [OPTIONS] [TITLE]`

## DESCRIPTION

The jekyll_post.sh script allows you to execute Jekyll commands and open files
related to your Jekyll site. It assumes the [Docker container][jekyll container] running the Jekyll
image is already set up, running in deamon (server and [jekyll compose][jekyll compose] plugin installed.

## OPTIONS

`-e <title>`

Create a new post with the given \<title> and open the corresponding file for editing.
If the \<title> contains spaces,
they will be replaced with hyphens (-) automatically.

## ARGUMENT

The `<title>` argument is the title of the post to be created.

## USAGE EXAMPLES

To create a new post and open the file for editing:
`make-post.sh -e 'Everything is okay'`

To execute a Jekyll command without opening a file:
`make-post.sh 'Everything is okay'`

Note: Replace "my-post-title" with the desired title for the post.

## ENVIRONMENT VARIABLES

`editor`
The script will use the value of the editor environment variable to determine the editor to open the file. If the variable is not set, the script will not be able to open the file automatically.

`post_path`
    The path where the created post files are located. Update the value of the post_path variable in the script to match the actual path on your system.

`jekyll_containter_name`
    The name of the Docker container running the Jekyll image. Update the value of the jekyll_containter_name variable in the script to match the actual container name.

[jekyll compose]: https://github.com/jekyll/jekyll-compose
[jekyll container]: https://hub.docker.com/r/jekyll/jekyll/
