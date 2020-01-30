# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

function __fish_docker_images_tags
  docker images 2>/dev/null | awk 'NR != 1 {print $3"\t",$1":"$2}'
end

function __fish_docker_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'docker' ]
    return 0
  end
  return 1
end

function __fish_docker_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

# Tag
complete -f -c docker -n '__fish_docker_needs_command' -a tag -d 'Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE'
complete -f -c docker -n '__fish_docker_using_command tag' -a '(__fish_docker_images_tags)' -d 'docker repository'

# Images
complete -f -c docker -n '__fish_docker_needs_command' -a images -d 'List images'

# ps
complete -f -c docker -n '__fish_docker_needs_command' -a ps -d 'List containers'

# cp
complete -f -c docker -n '__fish_docker_needs_command' -a cp -d 'Copy files/folders between a container and the local filesystem'

# build
complete -f -c docker -n '__fish_docker_needs_command' -a build -d 'Build an image from a Dockerfile'

# rmi
complete -f -c docker -n '__fish_docker_needs_command' -a rmi -d 'Remove one or more images'
complete -f -c docker -n '__fish_docker_using_command rmi' -a '(__fish_docker_images_tags)' -d 'docker repository'