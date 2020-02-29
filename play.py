#! /usr/bin/env python
import pygame.midi
import time

pygame.midi.init()

device = pygame.midi.get_default_output_id()
print('Default Output = {}'.format(device))
num_devices = pygame.midi.get_count();
device = -1
for i in range(0,num_devices):
    info = pygame.midi.get_device_info(i)
    if info[3]:
        print("Device {} = {}".format(i,info))
        if device == -1 and "Midi Through" not in info[1].decode("utf-8")  and "EWI" not in info[1].decode("utf-8"):
            device = i
print("Using device {}".format(device))

player = pygame.midi.Output(device)
player.set_instrument(0)
player.note_on(64, 127)
time.sleep(1)
player.note_off(64, 127)
del player
pygame.midi.quit()
