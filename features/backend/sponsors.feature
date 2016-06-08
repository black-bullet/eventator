@backend
Feature: Sponsors settings
    In order to change sponsors settings
    As an admin
    I should be able to edit sponsors settings

Background:
    Given following "Event":
        | ref    | title     | description                | startDate        | endDate          | venue              | email               | host                  |
        | event  | My event  | My another awesome event!  | 2016-03-01 10:00 | 2016-03-01 18:00 | Burj Khalifa Tower | eventator@email.com | http://localhost:8000 |
        | event2 | His event | His another awesome event! | 2016-04-01 10:00 | 2016-04-01 18:00 | Kuala-lumpur Tower | eventator@gmail.com | http://event2.com     |
    And following "EventTranslation":
        | event  | locale |
        | event  | ru_RU  |
        | event  | de_DE  |
        | event2 | ru_RU  |
    And following "Organizer":
        | ref        | title         | description                    | isActive | events       |
        | organizer  | My organizer  | My another awesome organizer!  | 1        | event,event2 |
        | organizer2 | His organizer | His another awesome organizer! | 1        | event2       |
    And following "OrganizerTranslation":
        | organizer   | locale |
        | organizer   | ru_RU  |
        | organizer2  | de_DE  |
    And following "Speech":
        | ref     | title                | description                            | language | events       |
        | speech  | symfony propagation  | world symfony expansion                | ru       | event        |
        | speech2 | php servers piece    | php most popular language              | en       | event        |
        | speech3 | doctrine must have   | what you docrtine project should have  | en       | event        |
        | speech4 | symfony propagation2 | world symfony expansion2               | en       | event2       |
        | speech5 | php servers piece2   | php most popular language2             | en       | event2       |
        | speech6 | doctrine must have2  | what you docrtine project should have2 | en       | event2       |

    And following "SpeechTranslation":
        | speech   | locale |
        | speech   | ru_RU  |
        | speech2  | de_DE  |
        | speech3  | de_DE  |
        | speech4  | ru_RU  |
        | speech5  | de_DE  |
        | speech6  | de_DE  |
    And following "Program":
        | ref             | title               | isTopic | isActive | startDate         | endDate           | events       | speech  |
        | program         | keynote             | 1       | 1        | 2016-03-01 10:00  | 2016-03-01 10:30  | event        |         |
        | program2        | alex_symfony        | 0       | 1        | 2016-03-01 10:30  | 2016-03-01 11:30  | event        | speech  |
        | program3        | phil_php            | 0       | 1        | 2016-03-01 11:30  | 2016-03-01 12:30  | event        | speech2 |
        | program4        | coffee1             | 1       | 1        | 2016-03-01 12:30  | 2016-03-01 13:00  | event        |         |
        | program5        | phil_doctrine       | 0       | 1        | 2016-03-01 13:00  | 2016-03-01 14:30  | event        | speech3 |
        | program6        | end_keynote         | 1       | 1        | 2016-03-01 14:30  | 2016-03-01 15:00  | event        |         |
        | program7        | after_party         | 1       | 1        | 2016-03-01 15:00  | 2016-03-01 18:00  | event        |         |
        | program8        | keynote             | 1       | 1        | 2016-04-01 10:00  | 2016-04-01 10:30  | event2       |         |
        | program9        | alex_symfony        | 0       | 1        | 2016-04-01 10:30  | 2016-04-01 11:30  | event2       | speech4 |
        | program10       | phil_php            | 0       | 1        | 2016-04-01 11:30  | 2016-04-01 12:30  | event2       | speech5 |
        | program11       | coffee1             | 1       | 1        | 2016-04-01 12:30  | 2016-04-01 13:00  | event2       |         |
        | program12       | phil_doctrine       | 0       | 1        | 2016-04-01 13:00  | 2016-04-01 14:30  | event2       | speech6 |
        | program13       | end_keynote         | 1       | 1        | 2016-04-01 14:30  | 2016-04-01 15:00  | event2       |         |
        | program14       | after_party         | 1       | 1        | 2016-04-01 15:00  | 2016-04-01 18:00  | event2       |         |
    And following "ProgramTranslation":
        | program   | locale |
        | program   | ru_RU  |
        | program2  | de_DE  |
        | program3  | de_DE  |
        | program4  | de_DE  |
        | program5  | de_DE  |
        | program6  | de_DE  |
        | program7  | de_DE  |
        | program8  | de_DE  |
        | program9  | de_DE  |
        | program10 | de_DE  |
        | program11 | de_DE  |
        | program12 | de_DE  |
        | program13 | de_DE  |
        | program14 | de_DE  |
    And following "Speaker":
        | ref      | firstName | lastName  | Company          | email | homepage           | twitter                     | events       | speeches                        |
        | speaker  | Phill     | Pilow     | Reseach Supplier |       |                    |                             | event,event2 | speech2,speech3,speech5,speech6 |
        | speaker2 | Alex      | Demchenko | KnpLabs          |       | http://451f.com.ua | https://twitter.com/twitter | event,event2 | speech,speech4                 |
    And following "SpeakerTranslation":
        | speaker   | locale |
        | speaker   | ru_RU  |
        | speaker2  | de_DE  |
    And following "Sponsor":
        | ref      | company          | description             | homepage            | type | isActive | events       |
        | sponsor  | Reseach Supplier | NASA research center    | http://nasa.gov.us  | 1    | 1        | event,event2 |
        | sponsor2 | KnpLabs          | Happy awesome developer | http://knplabs.com  | 2    | 1        | event        |
    And following "SponsorTranslation":
        | sponsor   | locale |
        | sponsor   | de_DE  |
        | sponsor2  | de_DE  |

@javascript
Scenario: Admin should have access to the sponsors manage
    Given I am sign in as admin
    When I click "Sponsors"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I should see the row containing "1;Reseach Supplier;My event, His event;Platinum"
    And I should see the row containing "2;KnpLabs;My event;Gold"
    When I click "Edit" on the row containing "2;KnpLabs;My event;Gold"
    Then I wait for a form
    Then I should see "Edit sponsor"

@javascript
Scenario: Admin should have able to add sponsor
    Given I am sign in as admin
    When I click "Sponsors"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I click "Add sponsor"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I fill in "Company" with "Lazy Ants"
    And I fill in "Description" with "Software and outsource provider company focused on development, trainings and consulting services for any kind of web and mobile base solutions."
    And I fill in "Homepage" with "http://lazy-ants.com"
    And I check "My event"
    And I check "His event"
    And I select "Platinum" from "Type"
    And I press "Add"
    Then I wait for a form
    Then I should see "Sponsor Lazy Ants added."
    Then I should see the row containing "3;Lazy Ants;My event, His event;Platinum"

@javascript
Scenario: Admin should have able to update sponsors settings
    Given I am sign in as admin
    When I click "Sponsors"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I should see the row containing "1;Reseach Supplier;My event, His event;Platinum"
    When I click "Edit" on the row containing "1;Reseach Supplier;My event, His event;Platinum"
    Then I wait for a form
    Then I should see "Edit sponsor"
    And I select "Gold" from "Type"
    And I press "Update"
    Then I wait for a form
    Then I should see "Sponsor Reseach Supplier updated."
    Then I should see the row containing "1;Reseach Supplier;My event, His event;Gold"

@javascript
Scenario: Admin should have delete to the sponsor
    Given I am sign in as admin
    When I click "Sponsors"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I should see the row containing "1;Reseach Supplier;My event, His event;Platinum"
    Then I delete the record with id "1"
    Then I wait for a form
    Then I should see "Sponsor deleted."
    Then I should not see the row containing "1;Reseach Supplier;My event, His event;Platinum"

@javascript
Scenario: Admin should have able to update Deutsch sponsors settings
    Given I am sign in as admin
    When I click "Sponsors"
    Then I wait for a form
    Then I should see "Add sponsor"
    And I should see the row containing "1;Reseach Supplier;My event, His event;Platinum"
    When I click "Edit" on the row containing "1;Reseach Supplier;My event, His event;Platinum"
    Then I wait for a form
    Then I should see "Edit sponsor"
    And I click "de"
    Then I wait for a form
    And I fills in "Company" with "name of company" inside "de" tab
    And I press "Update"
    Then I wait for a form
    Then I should see "Sponsor Reseach Supplier updated."
    Then I should see the row containing "1;Reseach Supplier;My event, His event;Platinum"
