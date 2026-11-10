import { getAllCategories } from '../models/categories.js';

const showCategoriesPage = async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Categories';

    res.render('categories', { title, categories });
};  

export { showCategoriesPage };

/*app.get('/categories', async (req, res) => {
    const categories = await getAllCategories();  
    const title = 'Service Projects Categories';

    res.render('categories', { title, categories });
});*/