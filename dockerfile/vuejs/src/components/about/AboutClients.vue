<script>
import imgAmazonGray from '@/assets/images/brands/amazon_gray.png';
import imgSonyGray from '@/assets/images/brands/sony_gray.png';
import imgAdidasGray from '@/assets/images/brands/adidas_gray.png';
import imgFilaGray from '@/assets/images/brands/fila_gray.png';
import imgNbGray from '@/assets/images/brands/nb_gray.png';
import imgSamsungGray from '@/assets/images/brands/samsung_gray.png';
import imgCanonGray from '@/assets/images/brands/canon_gray.png';
import imgPumaGray from '@/assets/images/brands/puma_gray.png';
import AboutClientSingle from './AboutClientSingle.vue';

export default {
	components: {
		AboutClientSingle,
	},
	data: () => {
		return {
			clientsHeading: 'Some of the brands I have worked with',
			clients: [
				{
					id: 1,
					title: 'Amazon',
					img: imgAmazonGray,
				},
				{
					id: 2,
					title: 'Sony',
					img: imgSonyGray,
				},
				{
					id: 3,
					title: 'Adidas',
					img: imgAdidasGray,
				},
				{
					id: 4,
					title: 'FILA',
					img: imgFilaGray,
				},
				{
					id: 5,
					title: 'NB',
					img: imgNbGray,
				},
				{
					id: 6,
					title: 'SAMSUNG',
					img: imgSamsungGray,
				},
				{
					id: 7,
					title: 'CANON',
					img: imgCanonGray,
				},
				{
					id: 7,
					title: 'PUMA',
					img: imgPumaGray,
				},
			],
		};
	},
};
</script>

<template>
	<div class="mt-10 sm:mt-20">
		<p
			class="font-general-medium text-2xl sm:text-3xl text-primary-dark dark:text-primary-light"
		>
			{{ clientsHeading }}
		</p>
		<div class="grid grid-cols-2 sm:grid-cols-4 mt-10 sm:mt-14 gap-2">
			<AboutClientSingle
				v-for="client in clients"
				:key="client.id"
				:client="client"
			/>
		</div>
	</div>
</template>
