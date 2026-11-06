--Organization table
CREATE TABLE organization (
	organization_id SERIAL PRIMARY KEY,
	org_name VARCHAR (150) NOT NULL,
	description TEXT NOT NULL,
	contact_email VARCHAR (255) NOT NULL,
	logo_filename VARCHAR (255) NOT NULL
);

--Insert simple data: Organizations
INSERT INTO organization (org_name, description, contact_email, logo_filename)
VALUES 
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

--Projects table 1:N
CREATE TABLE projects (
	project_id SERIAL PRIMARY KEY,
	title VARCHAR (150) NOT NULL,
	description TEXT NOT NULL,
	location VARCHAR (255) NOT NULL,
	date DATE NOT NULL,
	organization_id INT NOT NULL,
	FOREIGN KEY (organization_id) REFERENCES organization (organization_id)
);

--Service projects
    
INSERT INTO projects (
    organization_id,
    title,
    description,
    location,
    date
)

VALUES

-- BrightFuture Builders (Organization ID: 1)

(1, 'Community Library Renovation',
 'Renovation of a public library to improve accessibility and create a welcoming learning environment for local residents.',
 'Manizales, Colombia',
 '2026-11-15'),

(1, 'Sustainable Housing Initiative',
 'Construction improvements to provide safer and more sustainable housing for low-income families.',
 'Bogota, Colombia',
 '2026-11-22'),

(1, 'Neighborhood Playground Restoration',
 'Restoration of a community playground using sustainable materials and safer recreational equipment.',
 'Medellin, Colombia',
 '2026-12-05'),

(1, 'Community Center Improvement',
 'Infrastructure improvements to a local community center, including accessibility upgrades and renovated common areas.',
 'Pereira, Colombia',
 '2026-12-12'),

(1, 'Rural School Infrastructure Project',
 'Improvement of rural school facilities through classroom renovations and structural maintenance.',
 'Armenia, Colombia',
 '2026-12-19'),


-- GreenHarvest Growers (Organization ID: 2)

(2, 'Urban Community Garden',
 'Creation of a community garden where residents can grow fresh vegetables and learn sustainable agricultural practices.',
 'Manizales, Colombia',
 '2026-11-18'),

(2, 'School Gardening Program',
 'Educational gardening program designed to teach students about food production, environmental responsibility, and sustainability.',
 'Bogota, Colombia',
 '2026-11-25'),

(2, 'Neighborhood Composting Initiative',
 'Implementation of a community composting program to reduce organic waste and produce natural fertilizer.',
 'Medellin, Colombia',
 '2026-12-03'),

(2, 'Urban Tree Planting Project',
 'Planting native fruit trees and other suitable species in urban spaces to promote biodiversity and environmental awareness.',
 'Pereira, Colombia',
 '2026-12-10'),

(2, 'Sustainable Food Workshop',
 'Community workshops focused on sustainable food production, urban agriculture, and responsible consumption.',
 'Armenia, Colombia',
 '2026-12-17'),


-- UnityServe Volunteers (Organization ID: 3)

(3, 'Community Food Distribution',
 'Organization of volunteers to collect and distribute food supplies to families experiencing economic difficulties.',
 'Manizales, Colombia',
 '2026-11-20'),

(3, 'Elderly Community Support',
 'Volunteer initiative providing companionship and assistance to elderly members of the community.',
 'Bogota, Colombia',
 '2026-11-27'),

(3, 'Public Space Cleanup',
 'Community cleanup initiative involving volunteers in the collection of litter and maintenance of public spaces.',
 'Medellin, Colombia',
 '2026-12-07'),

(3, 'Children Education Support',
 'Volunteer program offering educational support and learning activities for children in underserved communities.',
 'Pereira, Colombia',
 '2026-12-14'),

(3, 'Community Donation Drive',
 'Collection and distribution of clothing, school supplies, and essential items for families in need.',
 'Armenia, Colombia',
 '2026-12-21');

--Categories N:M
CREATE TABLE categories (
	category_id INT PRIMARY KEY,
	category_name VARCHAR (100) NOT NULL
);

INSERT INTO categories (
    category_id,
	category_name
)
VALUES
(1, 'Environmental'),
(2, 'Educational'),
(3, 'Community Service'),
(4, 'Health and Wellness');

--Junction Table
CREATE TABLE service_project_categories (
	project_id INT NOT NULL,
	category_id INT NOT NULL,
	PRIMARY KEY (project_id, category_id),
	FOREIGN KEY (project_id) REFERENCES projects (project_id),
	FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

-- Insert Asociaciones 
INSERT INTO service_project_categories (
	project_id,
	category_id
)
VALUES
--BrightFuture Builders
(1, 2),
(1, 3),

(2, 1),
(2, 3),

(3, 3),
(3, 4),

(4, 3),
(4, 4),

(5, 2),
(5, 3),

-- GreenHarvest Growers
(6, 1),
(6, 2),

(7, 1),
(7, 2),

(8, 1),
(8, 2),

(9, 1),
(9, 3),

(10, 1),
(10, 2),
(10, 4),

-- UnityServe Volunteers
(11, 3),
(11, 4),

(12, 3),
(12, 4),

(13, 1),
(13, 3),

(14, 2),
(14, 3),

(15, 3);

--Info recovery
SELECT
    projects.project_id,
    projects.title,
    categories.category_id,
    categories.category_name

FROM projects

INNER JOIN service_project_categories

ON projects.project_id = service_project_categories.project_id

INNER JOIN categories

ON service_project_categories.category_id = categories.category_id

ORDER BY projects.project_id, categories.category_id;