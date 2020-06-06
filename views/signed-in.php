<?php $this->layout('layout', ['title' => $title]); ?>
<h1>VolumeLink</h1>
<p>You successfully signed in! Return to your TV to finish.</p>

<script>
window.history.replaceState({}, false, '/auth/redirect');
</script>
