<?php $this->layout('layout', ['title' => 'Enter Device Code']); ?>

<?php if($code): ?>
<p>Confirm the code below matches the code shown on the device.</p>
<?php else: ?>
<p>Enter the code shown on your device to continue.</p>
<?php endif ?>

<form action="/auth/verify_code" method="get">
  <input type="text" name="code" title="8 character code" placeholder="XXXX-XXXX" pattern="\w{4}-\w{4}" data-charset="____-____" class="masked" id="user_code" value="<?= $code ?>" autocomplete="off">
  <input type="submit">
</form>

<script>
document.getElementById("user_code").focus();
</script>

<script src="assets/masking-input.js" data-autoinit="true"></script>