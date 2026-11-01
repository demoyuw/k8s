import imgWebProject2 from '@/assets/images/web-project-2.jpg';
import imgMobileProject2 from '@/assets/images/mobile-project-2.jpg';
import imgUiProject1 from '@/assets/images/ui-project-1.jpg';
import imgUiProject2 from '@/assets/images/ui-project-2.jpg';
import imgMobileProject1 from '@/assets/images/mobile-project-1.jpg';
import imgWebProject1 from '@/assets/images/web-project-1.jpg';
// Projects data.
// Note: Here we are getting data from a js file, but in a different project I'll be fetching these projects from some srt of APIs.

const projects = [
	{
		id: 1,
		title: 'Google Health Platform',
		category: 'Web Application',
		img: imgWebProject2,
	},
	{
		id: 2,
		title: 'Phoenix Digital Agency',
		category: 'Mobile Application',
		img: imgMobileProject2,
	},
	{
		id: 3,
		title: 'Project Management UI',
		category: 'UI/UX Design',
		img: imgUiProject1,
	},
	{
		id: 4,
		title: 'Cloud Storage Platform',
		category: 'UI/UX Design',
		img: imgUiProject2,
	},
	{
		id: 5,
		title: 'React Social App',
		category: 'Mobile Application',
		img: imgMobileProject1,
	},
	{
		id: 6,
		title: 'Apple Design System',
		category: 'Web Application',
		img: imgWebProject1,
	},
];

export default projects;
