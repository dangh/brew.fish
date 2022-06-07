function brew --description "Patch homebrew to install latest stable bottles"
  set --local file_path (which brew | string replace 'bin/brew' 'Library/Homebrew/os/mac/version.rb')
  set --local file_content (string collect < $file_path)
  set --local current_version (/usr/bin/sw_vers -productVersion | math)
  if string match --quiet --regex '(?<current_name>\w+):\s+"'$current_version'",\n\s+(?<previous_name>\w+):' $file_content
    sed -i '' -E -e 's/'$current_name':[[:space:]]+/&"100",#/' -e 's/'$previous_name':[[:space:]]+/&"'$current_version'",#/' $file_path
  end
  command brew $argv
end
