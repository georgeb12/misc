#! /bin/bash
# Hipster computing
# a poem in code
# with inspiration from IFC's Portlandia
# 16 Jan 2015

which cowsay > /dev/null 2>&1

if [ $? -eq 1 ]; then
 echo "Please download COWSAY to get the full effect."
 exit 1
fi


echo -e "What a sad little computer...\n" \
        "I know, I'll put a bird on it.\n" \
        "Did you see this computer before?\n" \
        "I didn't.\n" \
        "Now there's a penguin.\n" \
        "It's flying;\n" \
        "it's FREE!" \
| cowsay -n -f tux

echo "Thanks Tux!"
echo "But I didn't know that penguins could fly..."

exit 0

