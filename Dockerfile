# Start from the official OJS image
# Be sure to use the specific version you are targeting
FROM pkpofficial/ojs:3_4_0-5

# Copy your corrected script into the image
# This path is a common location for entrypoint scripts
# You may need to verify the exact path in the original image
COPY my-docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# The CMD or ENTRYPOINT from the base image will automatically use this script.