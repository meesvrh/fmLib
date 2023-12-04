<script setup>
import { ref } from 'vue';
import useNuiEvent from '../composables/useNuiEvent';
import fetch from '../utils/fetch';

const visible = ref(false);
const timerInterval = ref(null);
const setProgressInterval = ref(null);
const status = ref(null);

const label = ref('');
const completedLabel = ref('');
const failedLabel = ref('');
const type = ref('linear');
const color = ref('primary');
const progress = ref(0);

const mockData = {
  label: 'Loading2',
  completedLabel: 'Completed',
  failedLabel: 'Failed',
  type: 'circular',
  time: 3000,
};

const clearIntervals = () => {
  if (timerInterval.value) clearInterval(timerInterval.value);
  if (setProgressInterval.value) clearInterval(setProgressInterval.value);
};

const stopProgress = (success) => {
  clearIntervals();

  completedLabel.value = success ? completedLabel.value : failedLabel.value;
  color.value = success ? 'success' : 'error';
  status.value = success;

  const stop = () => {
    setTimeout(() => {
        visible.value = false;
        fetch("progressStopped", success)
    }, 500);
  };

  if ((success && progress.value < 100) || (!success && progress.value > 0)) {
    setProgressInterval.value = setInterval(() => {
      if ((success && progress.value >= 100) || (!success && progress.value <= 0)) {
        clearInterval(setProgressInterval.value);
        stop();
      } else {
        progress.value += success ? 1 : -1;
      }
    }, 10);
  } else {
    stop();
  }
};

const startProgress = (data) => {
  clearIntervals();

  label.value = data.label.toUpperCase();
  completedLabel.value = data.completedLabel.toUpperCase();
  failedLabel.value = data.failedLabel.toUpperCase();
  type.value = data.type;

  status.value = null;
  color.value = 'primary';
  progress.value = 0;
  visible.value = true;

  const interval = data.time / 100;

  timerInterval.value = setInterval(() => {
    if (progress.value >= 100) {
      stopProgress(true);
    } else {
      progress.value += 1;
    }
  }, interval);
};

useNuiEvent('startProgress', startProgress);
useNuiEvent('stopProgress', stopProgress);
</script>

<template>
    <div v-if="visible">
        <v-progress-linear v-if="type === 'linear'"
            :model-value="progress"
            :color="color"
        ></v-progress-linear>
        <div v-if="type === 'circular'" class="font-semibold text-sm flex flex-col gap-4 justify-center items-center">
            <v-progress-circular
                :size="120" 
                :width="10" 
                :model-value="progress"
                :color="color"
            >
                {{ status !== null ? status === true ? completedLabel : failedLabel : progress + '%' }}
            </v-progress-circular>
            <span>{{ label }}</span>
        </div>
    </div>
    <v-btn @click="startProgress(mockData)">Toggle</v-btn>
    <v-btn color="red" @click="stopProgress(false)">Cancel</v-btn>
</template>