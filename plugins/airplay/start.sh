#!/bin/sh

# Copy the custom Shairport-Sync configuration file
if [ -f /usr/src/shairport-sync.conf ]; then
  echo "Copying custom Shairport-Sync configuration..."
  cp /usr/src/shairport-sync.conf /etc/shairport-sync.conf
else
  echo "Custom Shairport-Sync configuration not found. Using default configuration."
fi

if [[ -n "$SOUND_DISABLE_AIRPLAY" ]]; then
  echo "Airplay is disabled, exiting..."
  exit 0
fi

# --- ENV VARS ---
# SOUND_DEVICE_NAME: Set the device broadcast name for AirPlay
SOUND_DEVICE_NAME=${SOUND_DEVICE_NAME:-"balenaSound AirPlay $(echo "$BALENA_DEVICE_UUID" | cut -c -4)"}

echo "Starting AirPlay plugin..."
echo "Device name: $SOUND_DEVICE_NAME"

# Start AirPlay
echo "Starting Shairport Sync"
exec shairport-sync \
  --name "$SOUND_DEVICE_NAME" \
  --output alsa \
  -- -d pulse \
  | echo "Shairport-sync started. Device is discoverable as $SOUND_DEVICE_NAME"
