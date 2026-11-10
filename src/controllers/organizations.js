import { getAllOrganizations } from '../models/organizations.js';

// Define any controller functions
const showOrganizationsPage = async (req, res) => {
    const organizations = await getAllOrganizations();
    const title = 'Our Partner Organizations';

    res.render('organizations', { title, organizations });
};

export { showOrganizationsPage };

/*app.get('/organizations', async (req, res) => {
    const organizations = await getAllOrganizations();  
    const title = 'Our Partner Organizations';

    res.render('organizations', { title, organizations });
});*/