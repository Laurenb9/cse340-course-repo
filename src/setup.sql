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
