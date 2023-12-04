import { ref, onMounted, onBeforeUnmount } from 'vue';

export default function useNuiEvent(action, handler) {
  const savedHandler = ref(handler);

  const onHandlerChange = () => {
    savedHandler.value = handler;
  };

  onMounted(() => {
    const eventListener = (event) => {
      if (event.data.action === action && savedHandler.value) {
        savedHandler.value(event.data.data);
      }
    };

    window.addEventListener('message', eventListener);

    onBeforeUnmount(() => {
      window.removeEventListener('message', eventListener);
    });
  });

  return {
    savedHandler,
    onHandlerChange,
  };
}