<script>
export default {
	data: () => {
		return {
			visible: false,
		};
	},
	mounted() {
		window.addEventListener('scroll', this.onScroll, { passive: true });
		this.onScroll();
	},
	beforeUnmount() {
		window.removeEventListener('scroll', this.onScroll);
	},
	methods: {
		onScroll() {
			this.visible = window.scrollY > 500;
		},
		scrollToTop() {
			window.scrollTo({ top: 0, behavior: 'smooth' });
		},
	},
};
</script>

<template>
	<button
		v-show="visible"
		type="button"
		class="vue-back-to-top fixed shadow-lg"
		style="right: 30px; bottom: 20px"
		aria-label="Back to top"
		@click="scrollToTop"
	>
		<i data-feather="chevron-up"></i>
	</button>
</template>
