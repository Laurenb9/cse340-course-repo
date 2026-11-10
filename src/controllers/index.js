const showHomePage = async (req, res) => {
    const title = 'home';

    res.render('home', { title });
};

export {showHomePage};

/*app.get('/', async (req, res) => {
    const title = 'Home';
    res.render('home', { title });
});*/